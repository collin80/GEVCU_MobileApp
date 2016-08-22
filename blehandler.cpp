#include "blehandler.h"

BLEHandler::BLEHandler()
{
    discoveryAgent = new QBluetoothDeviceDiscoveryAgent(this);

    connect(discoveryAgent, SIGNAL(deviceDiscovered(const QBluetoothDeviceInfo&)),
            this, SLOT(addDevice(const QBluetoothDeviceInfo&)));
    connect(discoveryAgent, SIGNAL(error(QBluetoothDeviceDiscoveryAgent::Error)),
            this, SLOT(deviceScanError(QBluetoothDeviceDiscoveryAgent::Error)));
    connect(discoveryAgent, SIGNAL(finished()), this, SLOT(scanFinished()));

    bleController = 0;
    bleService = 0;

    m_timeRunning = 0;
    m_reqTorque = 0;
    m_actTorque = 0;
    m_rawThrottle1 = 0;
    m_rawThrottle2 = 0;
    m_rawBrake = 0;
    m_percBrake = 0;
    m_percThrottle = 0;
    m_reqRPM = 0;
    m_actRPM = 0;
    m_powerMode = 0;
    m_gear = 0;
    m_isRunning = false;
    m_isFaulted = false;
    m_isWarning = false;
    m_logLevel = 0;
    m_SOC = 0;
    m_busVoltage = 0;
    m_busCurrent = 0;
    m_motorCurrent = 0;
    m_kilowattHours = 0;
    m_mechPower = 0.0f;
    m_bitField1 = 0;
    m_bitField2 = 0;
    m_digitalInputs = 0;
    m_digitalOutputs = 0;
    m_motorTemperature = 0;
    m_inverterTemperature = 0;
    m_systemTemperature = 0;
    m_prechargeDuration = 0;
    m_prechargeOutput = 0;
    m_mainContactorOutput = 0;
    m_coolingOutput = 0;
    m_coolingOnTemp = 0;
    m_coolingOffTemp = 0;
    m_brakeLightOutput = 0;
    m_reverseLightOutput = 0;
    m_enableMotorControlInput = 0;
    m_reverseInput = 0;
    m_numThrottleADC = 0;
    m_throttleType = 0;
    m_throttle1Min = 0;
    m_throttle2Min = 0;
    m_throttle1Max = 0;
    m_throttle2Max = 0;
    m_regenMaxPedalPos = 0;
    m_regenMinPedalPos = 0;
    m_fwdMotionPedalPos = 0;
    m_mapPedalPos = 0;
    m_regenThrottleMin = 0;
    m_regenThrottleMax = 0;
    m_creepThrottle = 0;
    m_brakeMinADC = 0;
    m_brakeMaxADC = 0;
    m_regenBrakeMin = 0;
    m_regenBrakeMax = 0;
    m_nomBattVolts = 0;
    m_maxRPM = 0;
    m_maxTorque = 0;
    m_bleStatus = tr("Scanning for GEVCU");
    m_devicesEnabled = 0;

    discoveryAgent->start();
}


BLEHandler::~BLEHandler()
{
    qDeleteAll(bleDevices);
    bleDevices.clear();
}

void BLEHandler::deviceSearch()
{
    discoveryAgent->stop();
    qDeleteAll(bleDevices);
    bleDevices.clear();
    m_bleStatus = tr("Scanning for GEVCU");
    emit bleStatusChanged();
    discoveryAgent->start();
}

void BLEHandler::addDevice(const QBluetoothDeviceInfo &device)
{
    if (device.coreConfigurations() & QBluetoothDeviceInfo::LowEnergyCoreConfiguration) {
        qWarning() << "Discovered LE Device name: " << device.name() << " Address: "
                   << device.address().toString();
        BLEDeviceInfo *dev = new BLEDeviceInfo();
        dev->setDevice(device);
        bleDevices.append(dev);
    }
}

void BLEHandler::scanFinished()
{
    if (bleDevices.size() == 0)
    {
        //setMessage("No Low Energy devices found");
        qWarning() << "No BLE devices found!";
        m_bleStatus = "No devices found!";
        emit bleStatusChanged();
    }
    //Q_EMIT nameChanged();
    for (int i = 0; i < bleDevices.size(); i++)
    {
        if ( ((BLEDeviceInfo*)bleDevices.at(i))->getName().contains("GEVCU"))
        {
            m_bleStatus = tr("Connecting");
            emit bleStatusChanged();
            connectToService(((BLEDeviceInfo*)bleDevices.at(i))->getAddress() );
            return;
        }
    }
    qWarning() << "No GEVCU devices found to connect to!";
    m_bleStatus = "No GEVCU Found!";
    emit bleStatusChanged();

}

void BLEHandler::deviceScanError(QBluetoothDeviceDiscoveryAgent::Error error)
{
    //if (error == QBluetoothDeviceDiscoveryAgent::PoweredOffError)
        //setMessage("The Bluetooth adaptor is powered off, power it on before doing discovery.");
    //else if (error == QBluetoothDeviceDiscoveryAgent::InputOutputError)
        //setMessage("Writing or reading from the device resulted in an error.");
    //else
        //setMessage("An unknown error has occurred.");
}


//QVariant BLEHandler::name()
//{
//    return QVariant::fromValue(bleDevices);
//}

void BLEHandler::connectToService(const QString &address)
{
    bool deviceFound = false;
    for (int i = 0; i < bleDevices.size(); i++) {
        if (((BLEDeviceInfo*)bleDevices.at(i))->getAddress() == address ) {
            currentDevice.setDevice(((BLEDeviceInfo*)bleDevices.at(i))->getDevice());
            qWarning() << "Connecting to device " << ((BLEDeviceInfo*)bleDevices.at(i))->getAddress();
            deviceFound = true;
            break;
        }
    }
    // we are running demo mode
    if (!deviceFound) {
        //startDemo();
        return;
    }

    if (bleController) {
        bleController->disconnectFromDevice();
        delete bleController;
        bleController = 0;
    }

    bleController = new QLowEnergyController(currentDevice.getDevice(), this);
    connect(bleController, SIGNAL(serviceDiscovered(QBluetoothUuid)),
            this, SLOT(serviceDiscovered(QBluetoothUuid)));
    connect(bleController, SIGNAL(discoveryFinished()),
            this, SLOT(serviceScanDone()));
    connect(bleController, SIGNAL(error(QLowEnergyController::Error)),
            this, SLOT(controllerError(QLowEnergyController::Error)));
    connect(bleController, SIGNAL(connected()),
            this, SLOT(deviceConnected()));
    connect(bleController, SIGNAL(disconnected()),
            this, SLOT(deviceDisconnected()));

    bleController->connectToDevice();
}

void BLEHandler::deviceConnected()
{
    bleController->discoverServices();
}

void BLEHandler::deviceDisconnected()
{
    m_bleStatus = "Disconnected";
    emit bleStatusChanged();
    qWarning() << "Remote device disconnected";
}

void BLEHandler::serviceDiscovered(const QBluetoothUuid &gatt)
{
    qWarning() << "Found service " << QString::number(gatt.toUInt16(), 16);
    if (gatt.toUInt16() == 0x3100) {
        //setMessage("GEVCU service discovered. Waiting for service scan to be done...");
        qWarning() << "Found GEVCU service!";
        foundGEVCUService = true;
    }
}

void BLEHandler::serviceScanDone()
{
    qWarning() << "Done scanning services";

    if (bleService)
    {
        delete bleService;
        bleService = 0;
    }

    if (foundGEVCUService) {
        //setMessage("Connecting to service...");
        qWarning() << "Connecting to GEVCU service";
        bleService = bleController->createServiceObject(QBluetoothUuid((quint16)0x3100), this);
    }

    if (!bleService) {
        //setMessage("GEVCU Service not found.");
        m_bleStatus = "Service Error!";
        emit bleStatusChanged();
        return;
    }



    connect(bleService, SIGNAL(stateChanged(QLowEnergyService::ServiceState)),
            this, SLOT(serviceStateChanged(QLowEnergyService::ServiceState)));
    connect(bleService, SIGNAL(characteristicChanged(QLowEnergyCharacteristic,QByteArray)),
            this, SLOT(updateBLECharacteristic(QLowEnergyCharacteristic,QByteArray)));
    connect(bleService, SIGNAL(descriptorWritten(QLowEnergyDescriptor,QByteArray)),
            this, SLOT(confirmedDescriptorWrite(QLowEnergyDescriptor,QByteArray)));

    bleService->discoverDetails();
}

void BLEHandler::disconnectService()
{
    foundGEVCUService = false;

    if (bleDevices.isEmpty()) {
        //if (timer)
            //timer->stop();
        return;
    }

    //disable notifications
    if (bleDescriptor.isValid() && bleService) {
        bleService->writeDescriptor(bleDescriptor, QByteArray::fromHex("0000"));
    } else {
        bleController->disconnectFromDevice();
        delete bleService;
        bleService = 0;
    }
}

void BLEHandler::controllerError(QLowEnergyController::Error error)
{
    //setMessage("Cannot connect to remote device.");
    qWarning() << "Controller Error:" << error;
}

/*
 * Called whenever a notification subscribed characteristic changes
 */
void BLEHandler::updateBLECharacteristic(const QLowEnergyCharacteristic &c, const QByteArray &value)
{
    qWarning() << "Got characteristic update for id " << QString::number(c.uuid().toUInt16(), 16);

    const quint8 *data = reinterpret_cast<const quint8 *>(value.constData());

    for (int i = 0; i < value.length(); i++)
        qWarning() << QString::number(data[i], 16);

    switch (c.uuid().toUInt16())
    {
    case 0x3101:
        interpretCharacteristic3101(data);
        break;
    case 0x3102:
        interpretCharacteristic3102(data);
        break;
    case 0x3103:
        interpretCharacteristic3103(data);
        break;
    case 0x3104:
        interpretCharacteristic3104(data);
        break;
    case 0x3105:
        interpretCharacteristic3105(data);
        break;
    case 0x3106:
        interpretCharacteristic3106(data);
        break;
    case 0x3107:
        interpretCharacteristic3107(data);
        break;
    case 0x3108:
        interpretCharacteristic3108(data);
        break;
    case 0x3109:
        interpretCharacteristic3109(data);
        break;
    case 0x310A:
        interpretCharacteristic310A(data);
        break;
    case 0x310B:
        interpretCharacteristic310B(data);
        break;
    case 0x310C:
        interpretCharacteristic310C(data);
        break;
    case 0x310D:
        interpretCharacteristic310D(data);
        break;
    case 0x310E:
        interpretCharacteristic310E(data);
        break;
    case 0x31D0:
        interpretCharacteristic31D0(data);
        break;
    }
}

void BLEHandler::interpretCharacteristic3101(const quint8 *data)
{
    m_timeRunning = data[0] + (data[1] * 256ul) + (data[2] * 65536ul) + (data[3] * 16777216ul);

    emit timeRunningChanged();
}

void BLEHandler::interpretCharacteristic3102(const quint8 *data)
{
    qint16 temp;
    temp = (qint16)(data[0] + ((qint16)data[1] * 256l));
    if (temp != m_reqTorque)
    {
        m_reqTorque = temp;
        emit reqTorqueChanged();
    }

    temp = qint16(data[2] + ((qint16)data[3] * 256l));
    if (temp != m_actTorque)
    {
        m_actTorque = temp;
        emit actTorqueChanged();
    }
}

void BLEHandler::interpretCharacteristic3103(const quint8 *data)
{
    quint16 temp;

    temp = (quint16)(data[0] + (data[1] * 256ul));
    if (temp != m_rawThrottle1)
    {
        m_rawThrottle1 = temp;
        emit rawThrottle1Changed();
    }

    temp = (quint16)(data[2] + (data[3] * 256ul));
    if (temp != m_rawThrottle2)
    {
        m_rawThrottle2 = temp;
        emit rawThrottle2Changed();
    }

    temp = (quint16)(data[4] + (data[5] * 256ul));
    if (temp != m_rawBrake)
    {
        m_rawBrake = temp;
        emit rawBrakeChanged();
    }

    if (data[6] != m_percThrottle)
    {
        m_percThrottle = (signed char)data[6];
        emit percThrottleChanged();
    }

    if (data[7] != m_percBrake)
    {
        m_percBrake = (signed char)data[7];
        emit percBrakeChanged();
    }

}

void BLEHandler::interpretCharacteristic3104(const quint8 *data)
{
    quint16 temp;
    temp = (quint16)(data[0] + (data[1] * 256ul));
    if (temp != m_reqRPM)
    {
        m_reqRPM = temp;
        emit reqRPMChanged();
    }

    temp = quint16(data[2] + (data[3] * 256ul));
    if (temp != m_actRPM)
    {
        m_actRPM = temp;
        emit actRPMChanged();
    }
}

void BLEHandler::interpretCharacteristic3105(const quint8 *data)
{
    if (data[0] != m_powerMode)
    {
        m_powerMode = data[0];
        emit powerModeChanged();
    }

    if (data[1] != m_gear)
    {
        m_gear = data[1];
        emit gearChanged();
    }

    if (data[2] != m_isRunning)
    {
        m_isRunning = data[2];
        emit isRunningChanged();
    }

    if (data[3] != m_isFaulted)
    {
        m_isFaulted = data[3];
        emit isFaultedChanged();
    }

    if (data[4] != m_isWarning)
    {
        m_isWarning = data[4];
        emit isWarningChanged();
    }

    if (data[5] != m_logLevel)
    {
        m_logLevel = data[5];
        emit logLevelChanged();
    }
}

void BLEHandler::sendCharacteristic3105()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x3105));
    if (bleChar.isValid())
    {
        data.append((char)m_powerMode);
        data.append((char)m_gear);
        data.append((char)m_isRunning);
        data.append((char)m_isWarning);
        data.append((char)m_isFaulted);
        data.append((char)m_logLevel);

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

void BLEHandler::interpretCharacteristic3106(const quint8 *data)
{
    qint16 signedVal;
    quint16 unsignedVal;

    unsignedVal = quint16(data[0] + (data[1] * 256ul));
    if (unsignedVal != m_busVoltage)
    {
        m_busVoltage = unsignedVal;
        emit busVoltageChanged();
    }

    signedVal = qint16(data[2] + (data[3] * 256l));
    if (signedVal != m_busCurrent)
    {
        m_busCurrent = signedVal;
        emit busCurrentChanged();
    }

    signedVal = qint16(data[4] + (data[5] * 256l));
    if (signedVal != m_motorCurrent)
    {
        m_motorCurrent = signedVal;
        emit motorCurrentChanged();
    }

    unsignedVal = quint16(data[6] + (data[7] * 256l));
    if (unsignedVal != m_kilowattHours)
    {
        m_kilowattHours = unsignedVal;
        emit kilowattHoursChanged();
    }

    signedVal = qint16(data[8] + (data[9] * 256l));
    if (signedVal != m_mechPower)
    {
        m_mechPower = signedVal;
        emit mechPowerChanged();
    }

    if (data[10] != m_SOC)
    {
        m_SOC = data[10];
        emit SOCChanged();
    }
}

void BLEHandler::interpretCharacteristic3107(const quint8 *data)
{
    quint32 val;

    val = data[0] + (data[1] * 256ul) + (data[2] * 65536ul) + (data[3] * 16777216ul);
    if (val != m_bitField1)
    {
        m_bitField1 = val;
        emit bitField1Changed();
    }

    val = data[4] + (data[5] * 256ul) + (data[6] * 65536ul) + (data[7] * 16777216ul);
    if (val != m_bitField2)
    {
        m_bitField2 = val;
        emit bitField2Changed();
    }

    val = data[8] + (data[9] * 256ul) + (data[10] * 65536ul) + (data[11] * 16777216ul);
    if (val != m_digitalInputs)
    {
        m_digitalInputs = val;
        emit digitalInputsChanged();
    }

    val = data[12] + (data[13] * 256ul) + (data[14] * 65536ul) + (data[15] * 16777216ul);
    if (val != m_digitalOutputs)
    {
        m_digitalOutputs = val;
        emit digitalOutputsChanged();
    }
}

void BLEHandler::interpretCharacteristic3108(const quint8 *data)
{
    qint16 signedVal;

    signedVal = qint16(data[0] + (data[1] * 256l));
    if (signedVal != m_motorTemperature)
    {
        m_motorTemperature = signedVal;
        emit motorTemperatureChanged();
    }

    signedVal = qint16(data[2] + (data[3] * 256l));
    if (signedVal != m_inverterTemperature)
    {
        m_inverterTemperature = signedVal;
        emit inverterTemperatureChanged();
    }

    signedVal = qint16(data[4] + (data[5] * 256l));
    if (signedVal != m_systemTemperature)
    {
        m_systemTemperature = signedVal;
        emit systemTemperatureChanged();
    }
}

void BLEHandler::interpretCharacteristic3109(const quint8 *data)
{
    quint16 val;

    val = quint16(data[0] + (data[1] * 256ul));
    if (val != m_prechargeDuration)
    {
        m_prechargeDuration = val;
        emit prechargeDurationChanged();
    }

    if (data[2] != m_prechargeOutput)
    {
        m_prechargeOutput = data[2];
        emit prechargeOutputChanged();
    }

    if (data[3] != m_mainContactorOutput)
    {
        m_mainContactorOutput = data[3];
        emit mainContactorOutputChanged();
    }

    if (data[4] != m_coolingOutput)
    {
        m_coolingOutput = data[4];
        emit coolingOutputChanged();
    }

    if (data[5] != m_coolingOnTemp)
    {
        m_coolingOnTemp = data[5];
        emit coolingOnTempChanged();
    }

    if (data[6] != m_coolingOffTemp)
    {
        m_coolingOffTemp = data[6];
        emit coolingOffTempChanged();
    }

    if (data[7] != m_brakeLightOutput)
    {
        m_brakeLightOutput = data[7];
        emit brakeLightOutputChanged();
    }

    if (data[8] != m_reverseLightOutput)
    {
        m_reverseLightOutput = data[8];
        emit reverseLightOutputChanged();
    }

    if (data[9] != m_enableMotorControlInput)
    {
        m_enableMotorControlInput = data[9];
        emit enableMotorControlInputChanged();
    }

    if (data[10] != m_reverseInput)
    {
        m_reverseInput = data[10];
        emit reverseInputChanged();
    }
}

void BLEHandler::sendCharacteristic3109()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x3109));
    if (bleChar.isValid())
    {
        data.append((char)(m_prechargeDuration & 0xFF));
        data.append((char)(m_prechargeDuration >> 8));
        data.append((char)m_prechargeOutput);
        data.append((char)m_mainContactorOutput);
        data.append((char)m_coolingOutput);
        data.append((char)m_coolingOnTemp);
        data.append((char)m_coolingOffTemp);
        data.append((char)m_brakeLightOutput);
        data.append((char)m_reverseLightOutput);
        data.append((char)m_enableMotorControlInput);
        data.append((char)m_reverseInput);

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

void BLEHandler::interpretCharacteristic310A(const quint8 *data)
{
    quint16 val;

    val = quint16(data[0] + (data[1] * 256ul));
    if (val != m_throttle1Min)
    {
        m_throttle1Min = val;
        emit throttle1MinChanged();
    }

    val = quint16(data[2] + (data[3] * 256ul));
    if (val != m_throttle2Min)
    {
        m_throttle2Min = val;
        emit throttle2MinChanged();
    }

    val = quint16(data[4] + (data[5] * 256ul));
    if (val != m_throttle1Max)
    {
        m_throttle1Max = val;
        emit throttle1MaxChanged();
    }

    val = quint16(data[6] + (data[7] * 256ul));
    if (val != m_throttle2Max)
    {
        m_throttle2Max = val;
        emit throttle2MaxChanged();
    }
    if (data[8] != m_numThrottleADC)
    {
        m_numThrottleADC = data[8];
        emit numThrottleADCChanged();
    }

    if (data[9] != m_throttleType)
    {
        m_throttleType = data[9];
        emit throttleTypeChanged();
    }
}

void BLEHandler::sendCharacteristic310A()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x310A));
    if (bleChar.isValid())
    {
        data.append((char)(m_throttle1Min & 0xFF));
        data.append((char)(m_throttle1Min >> 8));
        data.append((char)(m_throttle2Min & 0xFF));
        data.append((char)(m_throttle2Min >> 8));
        data.append((char)(m_throttle1Max & 0xFF));
        data.append((char)(m_throttle1Max >> 8));
        data.append((char)(m_throttle2Max & 0xFF));
        data.append((char)(m_throttle2Max >> 8));
        data.append((char)m_numThrottleADC);
        data.append((char)m_throttleType);

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

void BLEHandler::interpretCharacteristic310B(const quint8 *data)
{
    quint16 val;

    val = quint16(data[0] + (data[1] * 256ul));
    if (val != m_regenMaxPedalPos)
    {
        m_regenMaxPedalPos = val;
        emit regenMaxPedalPosChanged();
    }

    val = quint16(data[2] + (data[3] * 256ul));
    if (val != m_regenMinPedalPos)
    {
        m_regenMinPedalPos = val;
        emit regenMinPedalPosChanged();
    }

    val = quint16(data[4] + (data[5] * 256ul));
    if (val != m_fwdMotionPedalPos)
    {
        m_fwdMotionPedalPos = val;
        emit fwdMotionPedalPosChanged();
    }

    val = quint16(data[6] + (data[7] * 256ul));
    if (val != m_mapPedalPos)
    {
        m_mapPedalPos = val;
        emit mapPedalPosChanged();
    }

    if (data[8] != m_regenThrottleMin)
    {
        m_regenThrottleMin = data[8];
        emit regenThrottleMinChanged();
    }

    if (data[9] != m_regenThrottleMax)
    {
        m_regenThrottleMax = data[9];
        emit regenThrottleMaxChanged();
    }

    if (data[10] != m_creepThrottle)
    {
        m_creepThrottle = data[10];
        emit creepThrottleChanged();
    }
}

void BLEHandler::sendCharacteristic310B()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x3105));
    if (bleChar.isValid())
    {
        data.append((char)(m_regenMaxPedalPos & 0xFF));
        data.append((char)(m_regenMaxPedalPos >> 8));
        data.append((char)(m_regenMinPedalPos & 0xFF));
        data.append((char)(m_regenMinPedalPos >> 8));
        data.append((char)(m_fwdMotionPedalPos & 0xFF));
        data.append((char)(m_fwdMotionPedalPos >> 8));
        data.append((char)(m_mapPedalPos & 0xFF));
        data.append((char)(m_mapPedalPos >> 8));
        data.append((char)m_regenThrottleMin);
        data.append((char)m_regenThrottleMax);
        data.append((char)m_creepThrottle);

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

void BLEHandler::interpretCharacteristic310C(const quint8 *data)
{
    quint16 val;

    val = quint16(data[0] + (data[1] * 256ul));
    if (val != m_brakeMinADC)
    {
        m_brakeMinADC = val;
        emit brakeMinADCChanged();
    }

    val = quint16(data[2] + (data[3] * 256ul));
    if (val != m_brakeMaxADC)
    {
        m_brakeMaxADC = val;
        emit brakeMaxADCChanged();
    }

    if (data[4] != m_regenBrakeMin)
    {
        m_regenBrakeMin = data[4];
        emit regenBrakeMinChanged();
    }

    if (data[5] != m_regenBrakeMax)
    {
        m_regenBrakeMax = data[5];
        emit regenBrakeMaxChanged();
    }
}

void BLEHandler::sendCharacteristic310C()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x3105));
    if (bleChar.isValid())
    {
        data.append((char)(m_brakeMinADC & 0xFF));
        data.append((char)(m_brakeMinADC >> 8));
        data.append((char)(m_brakeMaxADC & 0xFF));
        data.append((char)(m_brakeMaxADC >> 8));
        data.append((char)m_regenBrakeMin);
        data.append((char)m_regenBrakeMax);

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

void BLEHandler::interpretCharacteristic310D(const quint8 *data)
{
    quint16 val;

    val = quint16(data[0] + (data[1] * 256ul));
    if (val != m_nomBattVolts)
    {
        m_nomBattVolts = val;
        emit nomBattVoltsChanged();
    }

    val = quint16(data[2] + (data[3] * 256ul));
    if (val != m_maxRPM)
    {
        m_maxRPM = val;
        emit maxRPMChanged();
    }

    val = quint16(data[4] + (data[5] * 256ul));
    if (val != m_maxTorque)
    {
        m_maxTorque = val;
        emit maxTorqueChanged();
    }
}

void BLEHandler::sendCharacteristic310D()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x3105));
    if (bleChar.isValid())
    {
        data.append((char)(m_nomBattVolts & 0xFF));
        data.append((char)(m_nomBattVolts >> 8));
        data.append((char)(m_maxRPM & 0xFF));
        data.append((char)(m_maxRPM >> 8));
        data.append((char)(m_maxTorque & 0xFF));
        data.append((char)(m_maxTorque >> 8));

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

void BLEHandler::interpretCharacteristic310E(const quint8 *data)
{
    quint32 val;

    val = data[0] + (data[1] * 256ul) + (data[2] * 65536ul) + (data[3] * 16777216ul);
    if (val != m_devicesEnabled)
    {
        m_devicesEnabled = val;
        emit deviceDMOCChanged();
        emit deviceBrusaDMC5Changed();
        emit deviceCodaUQMChanged();
        emit deviceCKInverterChanged();
        emit deviceTestInverterChanged();
        emit deviceBrusaChargerChanged();
        emit deviceTCCHChanged();
        emit deviceLearChargerChanged();
        emit devicePotAccelChanged();
        emit devicePotBrakeChanged();
        emit deviceCANAccelChanged();
        emit deviceCANBrakeChanged();
        emit deviceTestAccelChanged();
        emit deviceEVICChanged();
        emit deviceAdaBlueChanged();
        emit deviceThinkBMSChanged();
        emit devicePIDListenChanged();
        emit deviceELM327EmuChanged();
    }
}

void BLEHandler::sendCharacteristic310E()
{
    QLowEnergyCharacteristic bleChar;
    QByteArray data;
    bleChar = bleService->characteristic(QBluetoothUuid((quint16)0x3105));
    if (bleChar.isValid())
    {
        data.append((char)(m_devicesEnabled & 0xFF));
        data.append((char)((m_devicesEnabled >> 8) & 0xFF));
        data.append((char)((m_devicesEnabled >> 16) & 0xFF));
        data.append((char)((m_devicesEnabled >> 24) & 0xFF));
        data.append((char)0); //fill second parameter with all zeros for now
        data.append((char)0);
        data.append((char)0);
        data.append((char)0);

        bleService->writeCharacteristic(bleChar, data, bleService->WriteWithResponse);
    }
}

//don't even really care... just ignore it.
void BLEHandler::interpretCharacteristic31D0(const quint8 *data)
{

}

/*
 *Called when discoverDetails() has gotten all of the characteristics and
 * their details. At this point it is possible to subscribe to characteristic
 * notifications. Also, the current value of all characteristics is available here.
 *
*/
void BLEHandler::serviceStateChanged(QLowEnergyService::ServiceState s)
{
    QLowEnergyCharacteristic bleChar;
    QLowEnergyDescriptor bleNotificationDesc;

    switch (s) {
    case QLowEnergyService::ServiceDiscovered:
    {
        QList<QLowEnergyCharacteristic> chars = bleService->characteristics();
        qWarning() << "Listing all chars";
        for (QLowEnergyCharacteristic bchar: chars)
        {
            qWarning() << "Char: " << QString::number(bchar.uuid().toUInt16(), 16);
        }

        for (int i = 0x3101; i < 0x310F; i++)
        {
            bleChar = bleService->characteristic(QBluetoothUuid((quint16)i));
            if (!bleChar.isValid()) {
                qWarning() << "Could not get characteristic " << QString::number(i, 16);
                //break;
            }

            //pretend we just got a notification in so that this char. is parsed
            updateBLECharacteristic(bleChar, bleChar.value());

            bleNotificationDesc = bleChar.descriptor(QBluetoothUuid::ClientCharacteristicConfiguration);
            if (bleNotificationDesc.isValid()) {
                //this line enables notifications for this characteristic.
                bleService->writeDescriptor(bleNotificationDesc, QByteArray::fromHex("0100"));
            }
        }
        m_bleStatus = "Connected";
        emit bleStatusChanged();
        break;
    }
    default:
        //nothing for now
        break;
    }
}


void BLEHandler::serviceError(QLowEnergyService::ServiceError e)
{
    switch (e) {
    case QLowEnergyService::DescriptorWriteError:
        //setMessage("Cannot obtain HR notifications");
        break;
    default:
        qWarning() << "BLE service error:" << e;
    }
}


void BLEHandler::confirmedDescriptorWrite(const QLowEnergyDescriptor &d,
                                         const QByteArray &value)
{
    if (d.isValid() && d == bleDescriptor && value == QByteArray("0000")) {
        //disabled notifications -> assume disconnect intent
        bleController->disconnectFromDevice();
        delete bleService;
        bleService = 0;
    }
}

QString BLEHandler::deviceAddress() const
{
    return currentDevice.getAddress();
}

int BLEHandler::numDevices() const
{
    return bleDevices.size();
}

//the motherload of getters and setters, all in a row
int BLEHandler::getTimeRunning()
{
    return m_timeRunning;
}

float BLEHandler::getRequestedTorque() const
{
    return m_reqTorque / 10.0f;
}


float BLEHandler::getActualTorque() const
{
    return m_actTorque / 10.0f;
}

int BLEHandler::getRawThrottle1() const
{
    return m_rawThrottle1;
}

int BLEHandler::getRawThrottle2() const
{
    return m_rawThrottle2;
}

int BLEHandler::getRawBrake() const
{
    return m_rawBrake;
}

int BLEHandler::getPercThrottle() const
{
    return m_percThrottle;
}

int BLEHandler::getPercBrake() const
{
    return m_percBrake;
}

int BLEHandler::getRequestedRPM() const
{
    return m_reqRPM;
}

int BLEHandler::getActualRPM() const
{
    return m_actRPM;
}

int BLEHandler::getPowerMode() const
{
    return m_powerMode;
}

void BLEHandler::setPowerMode(const int newMode)
{
    if (newMode == m_powerMode) return; //nothing to do!

    if (newMode > -1 && newMode < 2)
    {
        m_powerMode = newMode; //update local cache
        sendCharacteristic3105(); //update at GEVCU side
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit powerModeChanged();
    }
}

int BLEHandler::getGear() const
{
    return m_gear;
}

bool BLEHandler::getIsRunning() const
{
    return m_isRunning;
}

bool BLEHandler::getIsFaulted() const
{
    return m_isFaulted;
}

bool BLEHandler::getIsWarning() const
{
    return m_isWarning;
}

int BLEHandler::getSOC() const
{
    return m_SOC;
}

int BLEHandler::getLogLevel() const
{
    return m_logLevel;
}

void BLEHandler::setLogLevel(const int newLevel)
{
    if (newLevel == m_logLevel) return;

    if (newLevel > -1 && newLevel < 5)
    {
        m_logLevel = newLevel;
        sendCharacteristic3105();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit logLevelChanged();
    }
}

float BLEHandler::getBusVoltage() const
{
    return m_busVoltage / 10.0f;
}

float BLEHandler::getBusCurrent() const
{
    return m_busCurrent / 10.0f;
}

float BLEHandler::getMotorCurrent() const
{
    return m_motorCurrent / 10.0f;
}

float BLEHandler::getKWH() const
{
    return m_kilowattHours / 10.0f;
}

float BLEHandler::getMechPower() const
{
    return m_mechPower / 10.0f;
}

quint32 BLEHandler::getBitfield1() const
{
    return m_bitField1;
}

quint32 BLEHandler::getBitfield2() const
{
    return m_bitField2;
}

quint32 BLEHandler::getDigitalInputs() const
{
    return m_digitalInputs;
}

quint32 BLEHandler::getDigitalOutputs() const
{
    return m_digitalOutputs;
}

float BLEHandler::getMotorTemp() const
{
    return m_motorTemperature / 10.0f;
}

float BLEHandler::getInverterTemp() const
{
    return m_inverterTemperature / 10.0f;
}

float BLEHandler::getSysTemp() const
{
    return m_systemTemperature / 10.0f;
}

int BLEHandler::getPrechargeDuration() const
{
    return m_prechargeDuration;
}

void BLEHandler::setPrechargeDuration(const int newVal)
{
    if (newVal == m_prechargeDuration) return;

    if (newVal > -1)
    {
        m_prechargeDuration = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit prechargeDurationChanged();
    }
}

int BLEHandler::getPrechargeOutput() const
{
    return m_prechargeOutput;
}

void BLEHandler::setPrechargeOutput(const int newVal)
{
    if (newVal == m_prechargeOutput) return;

    if (newVal > -1)
    {
        m_prechargeOutput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit prechargeOutputChanged();
    }
}

int BLEHandler::getMainContactorOutput() const
{
    return m_mainContactorOutput;
}

void BLEHandler::setMainContactorOutput(const int newVal)
{
    if (newVal == m_mainContactorOutput) return;

    if (newVal > -1 && newVal < 8)
    {
        m_mainContactorOutput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit mainContactorOutputChanged();
    }
}

int BLEHandler::getCoolingOutput() const
{
    return m_coolingOutput;
}

void BLEHandler::setCoolingOutput(const int newVal)
{
    if (newVal == m_coolingOutput) return;

    if (newVal > -1 && newVal < 8)
    {
        m_coolingOutput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit coolingOutputChanged();
    }
}

int BLEHandler::getCoolingOnTemp() const
{
    return m_coolingOnTemp;
}

void BLEHandler::setCoolingOnTemp(const int newVal)
{
    if (newVal == m_coolingOnTemp) return;

    if (newVal > -1 && newVal < 250)
    {
        m_coolingOnTemp = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit coolingOnTempChanged();
    }
}

int BLEHandler::getCoolingOffTemp() const
{
    return m_coolingOffTemp;
}

void BLEHandler::setCoolingOffTemp(const int newVal)
{
    if (newVal == m_coolingOffTemp) return;

    if (newVal > -1 && newVal < 250)
    {
        m_coolingOffTemp = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit coolingOffTempChanged();
    }
}

int BLEHandler::getBrakeLightOutput() const
{
    return m_brakeLightOutput;
}

void BLEHandler::setBrakeLightOutput(const int newVal)
{
    if (newVal == m_brakeLightOutput) return;

    if (newVal > -1 && newVal < 8)
    {
        m_brakeLightOutput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit brakeLightOutputChanged();
    }

}

int BLEHandler::getReverseLightOutput() const
{
    return m_reverseLightOutput;
}

void BLEHandler::setReverseLightOutput(const int newVal)
{
    if (newVal == m_reverseLightOutput) return;

    if (newVal > -1 && newVal < 8)
    {
        m_reverseLightOutput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit reverseLightOutputChanged();
    }
}

int BLEHandler::getEnableMotorControlInput() const
{
    return m_enableMotorControlInput;
}

void BLEHandler::setEnableMotorControlInput(const int newVal)
{
    if (newVal == m_enableMotorControlInput) return;

    if (newVal > -1 && newVal < 4)
    {
        m_enableMotorControlInput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit enableMotorControlInputChanged();
    }
}

int BLEHandler::getReverseInput() const
{
    return m_reverseInput;
}

void BLEHandler::setReverseInput(const int newVal)
{
    if (newVal == m_reverseInput) return;

    if (newVal > -1 && newVal < 4)
    {
        m_reverseInput = newVal;
        sendCharacteristic3109();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit reverseInputChanged();
    }
}

int BLEHandler::getNumThrottleADC() const
{
    return m_numThrottleADC;
}

void BLEHandler::setNumThrottleADC(const int newVal)
{
    if (newVal == m_numThrottleADC) return;

    if (newVal > -1 && newVal < 4)
    {
        m_numThrottleADC = newVal;
        sendCharacteristic310A();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit numThrottleADCChanged();
    }
}

int BLEHandler::getThrottleType() const
{
    return m_throttleType;
}

void BLEHandler::setThrottleType(const int newVal)
{
    if (newVal == m_throttleType) return;

    if (newVal > -1 && newVal < 2)
    {
        m_throttleType = newVal;
        sendCharacteristic310A();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit throttleTypeChanged();
    }
}

int BLEHandler::getThrottle1Min() const
{
    return m_throttle1Min;
}

void BLEHandler::setThrottle1Min(const int newVal)
{
    if (newVal == m_throttle1Min) return;

    if (newVal > -1)
    {
        m_throttle1Min = newVal;
        sendCharacteristic310A();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit throttle1MinChanged();
    }
}

int BLEHandler::getThrottle2Min() const
{
    return m_throttle2Min;
}

void BLEHandler::setThrottle2Min(const int newVal)
{
    if (newVal == m_throttle2Min) return;

    if (newVal > -1)
    {
        m_throttle2Min = newVal;
        sendCharacteristic310A();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit throttle2MinChanged();
    }

}

int BLEHandler::getThrottle1Max() const
{
    return m_throttle1Max;
}

void BLEHandler::setThrottle1Max(const int newVal)
{
    if (newVal == m_throttle1Max) return;

    if (newVal > -1)
    {
        m_throttle1Max = newVal;
        sendCharacteristic310A();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit throttle1MaxChanged();
    }

}

int BLEHandler::getThrottle2Max() const
{
    return m_throttle2Max;
}

void BLEHandler::setThrottle2Max(const int newVal)
{
    if (newVal == m_throttle2Max) return;

    if (newVal > -1)
    {
        m_throttle2Max = newVal;
        sendCharacteristic310A();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit throttle2MaxChanged();
    }
}

int BLEHandler::getRegenMaxPedalPos() const
{
    return m_regenMaxPedalPos / 10;
}

void BLEHandler::setRegenMaxPedalPos(const int newVal)
{
    if (newVal == m_regenMaxPedalPos) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_regenMaxPedalPos = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit regenMaxPedalPosChanged();
    }

}

int BLEHandler::getRegenMinPedalPos() const
{
    return m_regenMinPedalPos / 10;
}

void BLEHandler::setRegenMinPedalPos(const int newVal)
{
    if (newVal == m_regenMinPedalPos) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_regenMinPedalPos = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit regenMinPedalPosChanged();
    }
}

int BLEHandler::getFWDMotionPedalPos() const
{
    return m_fwdMotionPedalPos / 10;
}

void BLEHandler::setFWDMotionPedalPos(const int newVal)
{
    if (newVal == m_fwdMotionPedalPos) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_fwdMotionPedalPos = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit fwdMotionPedalPosChanged();
    }
}

int BLEHandler::getMapPedalPos() const
{
    return m_mapPedalPos / 10;
}

void BLEHandler::setMapPedalPos(const int newVal)
{
    if (newVal == m_mapPedalPos) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_mapPedalPos = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit mapPedalPosChanged();
    }
}

int BLEHandler::getRegenThrottleMin() const
{
    return m_regenThrottleMin / 10;
}

void BLEHandler::setRegenThrottleMin(const int newVal)
{
    if (newVal == m_regenThrottleMin) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_regenThrottleMin = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit regenThrottleMinChanged();
    }
}

int BLEHandler::getRegenThrottleMax() const
{
    return m_regenThrottleMax / 10;
}

void BLEHandler::setRegenThrottleMax(const int newVal)
{
    if (newVal == m_regenThrottleMax) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_regenThrottleMax = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit regenThrottleMaxChanged();
    }
}

int BLEHandler::getCreepThrottle() const
{
    return m_creepThrottle / 10;
}

void BLEHandler::setCreepThrottle(const int newVal)
{
    if (newVal == m_creepThrottle) return;

    if (newVal > -1 && newVal < 1001)
    {
        m_creepThrottle = newVal;
        sendCharacteristic310B();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit creepThrottleChanged();
    }
}

int BLEHandler::getBrakeMinADC() const
{
    return m_brakeMinADC;
}

void BLEHandler::setBrakeMinADC(const int newVal)
{
    if (newVal == m_brakeMinADC) return;

    if (newVal > -1)
    {
        m_brakeMinADC = newVal;
        sendCharacteristic310C();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit brakeMinADCChanged();
    }
}

int BLEHandler::getBrakeMaxADC() const
{
    return m_brakeMaxADC;
}

void BLEHandler::setBrakeMaxADC(const int newVal)
{
    if (newVal == m_brakeMaxADC) return;

    if (newVal > -1)
    {
        m_brakeMaxADC = newVal;
        sendCharacteristic310C();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit brakeMaxADCChanged();
    }
}

int BLEHandler::getRegenBrakeMin() const
{
    return m_regenBrakeMin;
}

void BLEHandler::setRegenBrakeMin(const int newVal)
{
    if (newVal == m_brakeMinADC) return;

    if (newVal > -1)
    {
        m_brakeMinADC = newVal;
        sendCharacteristic310C();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit brakeMinADCChanged();
    }
}

int BLEHandler::getRegenBrakeMax() const
{
    return m_regenBrakeMax;
}

void BLEHandler::setRegenBrakeMax(const int newVal)
{
    if (newVal == m_brakeMaxADC) return;

    if (newVal > -1)
    {
        m_brakeMaxADC = newVal;
        sendCharacteristic310C();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit brakeMaxADCChanged();
    }
}

float BLEHandler::getNominalVoltage() const
{
    return m_nomBattVolts / 10.0f;
}

void BLEHandler::setNominalVoltage(const int newVal)
{
    if (newVal == m_nomBattVolts) return;

    if (newVal > -1)
    {
        m_nomBattVolts = newVal;
        sendCharacteristic310D();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit nomBattVoltsChanged();
    }
}

int BLEHandler::getMaxRPM() const
{
    return m_maxRPM;
}

void BLEHandler::setMaxRPM(const int newVal)
{
    if (newVal == m_maxRPM) return;

    if (newVal > -1)
    {
        m_maxRPM = newVal;
        sendCharacteristic310D();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit maxRPMChanged();
    }
}

int BLEHandler::getMaxTorque() const
{
    return m_maxTorque;
}

void BLEHandler::setMaxTorque(const int newVal)
{
    if (newVal == m_maxTorque) return;

    if (newVal > -1)
    {
        m_maxTorque = newVal;
        sendCharacteristic310D();
    }
    else
    {
        //cause the value to revert back to our saved value.
        emit maxTorqueChanged();
    }
}

QString BLEHandler::getBLEStatus()
{
    return m_bleStatus;
}

int BLEHandler::getDeviceDMOC() const
{
    if (m_devicesEnabled & 1) return 1;
    return 0;
}

void BLEHandler::setDeviceDMOC(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 1;
    else m_devicesEnabled &= ~1;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceBrusaDMC5() const
{
    if (m_devicesEnabled & 2) return 1;
    return 0;
}

void BLEHandler::setDeviceBrusaDMC5(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 2;
    else m_devicesEnabled &= ~2;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceCodaUQM() const
{
    if (m_devicesEnabled & 4) return 1;
    return 0;
}

void BLEHandler::setDeviceCodaUQM(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 4;
    else m_devicesEnabled &= ~4;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceCKInverter() const
{
    if (m_devicesEnabled & 8) return 1;
    return 0;
}

void BLEHandler::setDeviceCKInverter(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 8;
    else m_devicesEnabled &= ~8;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceTestInverter() const
{
    if (m_devicesEnabled & 0x10) return 1;
    return 0;
}

void BLEHandler::setDeviceTestInverter(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x10;
    else m_devicesEnabled &= ~0x10;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceBrusaCharger() const
{
    if (m_devicesEnabled & 0x20) return 1;
    return 0;
}

void BLEHandler::setDeviceBrusaCharger(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x20;
    else m_devicesEnabled &= ~0x20;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceTCCH() const
{
    if (m_devicesEnabled & 0x40) return 1;
    return 0;
}

void BLEHandler::setDeviceTCCH(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x40;
    else m_devicesEnabled &= ~0x40;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceLearCharger() const
{
    if (m_devicesEnabled & 0x80) return 1;
    return 0;
}

void BLEHandler::setDeviceLearCharger(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x80;
    else m_devicesEnabled &= ~0x80;

    sendCharacteristic310E();
}

int BLEHandler::getDevicePotAccel() const
{
    if (m_devicesEnabled & 0x100) return 1;
    return 0;
}

void BLEHandler::setDevicePotAccel(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x100;
    else m_devicesEnabled &= ~0x100;

    sendCharacteristic310E();
}

int BLEHandler::getDevicePotBrake() const
{
    if (m_devicesEnabled & 0x200) return 1;
    return 0;
}

void BLEHandler::setDevicePotBrake(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x200;
    else m_devicesEnabled &= ~0x200;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceCANAccel() const
{
    if (m_devicesEnabled & 0x400) return 1;
    return 0;
}

void BLEHandler::setDeviceCANAccel(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x400;
    else m_devicesEnabled &= ~0x400;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceCANBrake() const
{
    if (m_devicesEnabled & 0x800) return 1;
    return 0;
}

void BLEHandler::setDeviceCANBrake(const int newVal)
{

    if (newVal == 1) m_devicesEnabled |= 0x800;
    else m_devicesEnabled &= ~0x800;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceTestAccel() const
{
    if (m_devicesEnabled & 0x1000) return 1;
    return 0;
}

void BLEHandler::setDeviceTestAccel(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x1000;
    else m_devicesEnabled &= ~0x1000;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceEVIC() const
{
    if (m_devicesEnabled & 0x2000) return 1;
    return 0;
}

void BLEHandler::setDeviceEVIC(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x2000;
    else m_devicesEnabled &= ~0x2000;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceAdaBlue() const
{
    if (m_devicesEnabled & 0x4000) return 1;
    return 0;
}

void BLEHandler::setDeviceAdaBlue(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x4000;
    else m_devicesEnabled &= ~0x4000;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceThinkBMS() const
{
    if (m_devicesEnabled & 0x8000) return 1;
    return 0;
}

void BLEHandler::setDeviceThinkBMS(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x8000;
    else m_devicesEnabled &= ~0x8000;

    sendCharacteristic310E();
}

int BLEHandler::getDevicePIDListen() const
{
    if (m_devicesEnabled & 0x10000) return 1;
    return 0;
}

void BLEHandler::setDevicePIDListen(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x10000;
    else m_devicesEnabled &= ~0x10000;

    sendCharacteristic310E();
}

int BLEHandler::getDeviceELM327Emu() const
{
    if (m_devicesEnabled & 0x20000) return 1;
    return 0;
}

void BLEHandler::setDeviceELM327Emu(const int newVal)
{
    if (newVal == 1) m_devicesEnabled |= 0x20000;
    else m_devicesEnabled &= ~0x20000;

    sendCharacteristic310E();
}
