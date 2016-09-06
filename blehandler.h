#ifndef BLEHANDLER_H
#define BLEHANDLER_H

#include <QObject>
#include <QBluetoothDeviceDiscoveryAgent>
#include <QBluetoothDeviceInfo>
#include <QLowEnergyController>
#include <QLowEnergyService>
#include "bledeviceinfo.h"

class BLEHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString bleStatus READ getBLEStatus NOTIFY bleStatusChanged)
    Q_PROPERTY(int timeRunning READ getTimeRunning NOTIFY timeRunningChanged)
    Q_PROPERTY(float reqTorque READ getRequestedTorque NOTIFY reqTorqueChanged)
    Q_PROPERTY(float actTorque READ getActualTorque NOTIFY actTorqueChanged)
    Q_PROPERTY(int rawThrottle1 READ getRawThrottle1 NOTIFY rawThrottle1Changed)
    Q_PROPERTY(int rawThrottle2 READ getRawThrottle2 NOTIFY rawThrottle2Changed)
    Q_PROPERTY(int rawBrake READ getRawBrake NOTIFY rawBrakeChanged)
    Q_PROPERTY(int percThrottle READ getPercThrottle NOTIFY percThrottleChanged)
    Q_PROPERTY(int percBrake READ getPercBrake NOTIFY percBrakeChanged)
    Q_PROPERTY(int reqRPM READ getRequestedRPM NOTIFY reqRPMChanged)
    Q_PROPERTY(int actRPM READ getActualRPM NOTIFY actRPMChanged)
    Q_PROPERTY(int powerMode READ getPowerMode WRITE setPowerMode NOTIFY powerModeChanged)
    Q_PROPERTY(int gear READ getGear NOTIFY gearChanged)
    Q_PROPERTY(bool isRunning READ getIsRunning NOTIFY isRunningChanged)
    Q_PROPERTY(bool isFaulted READ getIsFaulted NOTIFY isFaultedChanged)
    Q_PROPERTY(bool isWarning READ getIsWarning NOTIFY isWarningChanged)
    Q_PROPERTY(int logLevel READ getLogLevel WRITE setLogLevel NOTIFY logLevelChanged)
    Q_PROPERTY(int SOC READ getSOC NOTIFY SOCChanged)
    Q_PROPERTY(float busVoltage READ getBusVoltage NOTIFY busVoltageChanged)
    Q_PROPERTY(float busCurrent READ getBusCurrent NOTIFY busCurrentChanged)    
    Q_PROPERTY(float motorCurrent READ getMotorCurrent NOTIFY motorCurrentChanged)
    Q_PROPERTY(float kilowattHours READ getKWH NOTIFY kilowattHoursChanged)
    Q_PROPERTY(float mechPower READ getMechPower NOTIFY mechPowerChanged)
    Q_PROPERTY(quint32 bitField1 READ getBitfield1 NOTIFY bitField1Changed)
    Q_PROPERTY(quint32 bitField2 READ getBitfield2 NOTIFY bitField2Changed)
    Q_PROPERTY(quint32 digitalInputs READ getDigitalInputs NOTIFY digitalInputsChanged)
    Q_PROPERTY(quint32 digitalOutputs READ getDigitalOutputs NOTIFY digitalOutputsChanged)
    Q_PROPERTY(float motorTemperature READ getMotorTemp NOTIFY motorTemperatureChanged)
    Q_PROPERTY(float inverterTemperature READ getInverterTemp NOTIFY inverterTemperatureChanged)
    Q_PROPERTY(float systemTemperature READ getSysTemp NOTIFY systemTemperatureChanged)
    Q_PROPERTY(int prechargeDuration READ getPrechargeDuration WRITE setPrechargeDuration NOTIFY prechargeDurationChanged)
    Q_PROPERTY(int prechargeOutput READ getPrechargeOutput WRITE setPrechargeOutput NOTIFY prechargeOutputChanged)
    Q_PROPERTY(int mainContactorOutput READ getMainContactorOutput WRITE setMainContactorOutput NOTIFY mainContactorOutputChanged)
    Q_PROPERTY(int coolingOutput READ getCoolingOutput WRITE setCoolingOutput NOTIFY coolingOutputChanged)
    Q_PROPERTY(int coolingOnTemp READ getCoolingOnTemp WRITE setCoolingOnTemp NOTIFY coolingOnTempChanged)
    Q_PROPERTY(int coolingOffTemp READ getCoolingOffTemp WRITE setCoolingOffTemp NOTIFY coolingOffTempChanged)
    Q_PROPERTY(int brakeLightOutput READ getBrakeLightOutput WRITE setBrakeLightOutput NOTIFY brakeLightOutputChanged)
    Q_PROPERTY(int reverseLightOutput READ getReverseLightOutput WRITE setReverseLightOutput NOTIFY reverseLightOutputChanged)
    Q_PROPERTY(int enableMotorControlInput READ getEnableMotorControlInput WRITE setEnableMotorControlInput NOTIFY enableMotorControlInputChanged)
    Q_PROPERTY(int reverseInput READ getReverseInput WRITE setReverseInput NOTIFY reverseInputChanged)
    Q_PROPERTY(int numThrottleADC READ getNumThrottleADC WRITE setNumThrottleADC NOTIFY numThrottleADCChanged)
    Q_PROPERTY(int throttleType READ getThrottleType WRITE setThrottleType NOTIFY throttleTypeChanged)
    Q_PROPERTY(int throttle1Min READ getThrottle1Min WRITE setThrottle1Min NOTIFY throttle1MinChanged)
    Q_PROPERTY(int throttle2Min READ getThrottle2Min WRITE setThrottle2Min NOTIFY throttle2MinChanged)
    Q_PROPERTY(int throttle1Max READ getThrottle1Max WRITE setThrottle1Max NOTIFY throttle1MaxChanged)
    Q_PROPERTY(int throttle2Max READ getThrottle2Max WRITE setThrottle2Max NOTIFY throttle2MaxChanged)
    Q_PROPERTY(int regenMaxPedalPos READ getRegenMaxPedalPos WRITE setRegenMaxPedalPos NOTIFY regenMaxPedalPosChanged)
    Q_PROPERTY(int regenMinPedalPos READ getRegenMinPedalPos WRITE setRegenMinPedalPos NOTIFY regenMinPedalPosChanged)
    Q_PROPERTY(int fwdMotionPedalPos READ getFWDMotionPedalPos WRITE setFWDMotionPedalPos NOTIFY fwdMotionPedalPosChanged)
    Q_PROPERTY(int mapPedalPos READ getMapPedalPos WRITE setMapPedalPos NOTIFY mapPedalPosChanged)
    Q_PROPERTY(int regenThrottleMin READ getRegenThrottleMin WRITE setRegenThrottleMin NOTIFY regenThrottleMinChanged)
    Q_PROPERTY(int regenThrottleMax READ getRegenThrottleMax WRITE setRegenThrottleMax NOTIFY regenThrottleMaxChanged)
    Q_PROPERTY(int creepThrottle READ getCreepThrottle WRITE setCreepThrottle NOTIFY creepThrottleChanged)
    Q_PROPERTY(int brakeMinADC READ getBrakeMinADC WRITE setBrakeMinADC NOTIFY brakeMinADCChanged)
    Q_PROPERTY(int brakeMaxADC READ getBrakeMaxADC WRITE setBrakeMaxADC NOTIFY brakeMaxADCChanged)
    Q_PROPERTY(int regenBrakeMin READ getRegenBrakeMin WRITE setRegenBrakeMin NOTIFY regenBrakeMinChanged)
    Q_PROPERTY(int regenBrakeMax READ getRegenBrakeMax WRITE setRegenBrakeMax NOTIFY regenBrakeMaxChanged)
    Q_PROPERTY(float nomBattVolts READ getNominalVoltage WRITE setNominalVoltage NOTIFY nomBattVoltsChanged)
    Q_PROPERTY(int maxRPM READ getMaxRPM WRITE setMaxRPM NOTIFY maxRPMChanged)
    Q_PROPERTY(int maxTorque READ getMaxTorque WRITE setMaxTorque NOTIFY maxTorqueChanged)

    Q_PROPERTY(int deviceDMOC READ getDeviceDMOC WRITE setDeviceDMOC NOTIFY deviceDMOCChanged)
    Q_PROPERTY(int deviceBrusaDMC5 READ getDeviceBrusaDMC5 WRITE setDeviceBrusaDMC5 NOTIFY deviceBrusaDMC5Changed)
    Q_PROPERTY(int deviceCodaUQM READ getDeviceCodaUQM WRITE setDeviceCodaUQM NOTIFY deviceCodaUQMChanged)
    Q_PROPERTY(int deviceCKInverter READ getDeviceCKInverter WRITE setDeviceCKInverter NOTIFY deviceCKInverterChanged)
    Q_PROPERTY(int deviceTestInverter READ getDeviceTestInverter WRITE setDeviceTestInverter NOTIFY deviceTestInverterChanged)
    Q_PROPERTY(int deviceBrusaCharger READ getDeviceBrusaCharger WRITE setDeviceBrusaCharger NOTIFY deviceBrusaChargerChanged)
    Q_PROPERTY(int deviceTCCH READ getDeviceTCCH WRITE setDeviceTCCH NOTIFY deviceTCCHChanged)
    Q_PROPERTY(int deviceLearCharger READ getDeviceLearCharger WRITE setDeviceLearCharger NOTIFY deviceLearChargerChanged)
    Q_PROPERTY(int devicePotAccel READ getDevicePotAccel WRITE setDevicePotAccel NOTIFY devicePotAccelChanged)
    Q_PROPERTY(int devicePotBrake READ getDevicePotBrake WRITE setDevicePotBrake NOTIFY devicePotBrakeChanged)
    Q_PROPERTY(int deviceCANAccel READ getDeviceCANAccel WRITE setDeviceCANAccel NOTIFY deviceCANAccelChanged)
    Q_PROPERTY(int deviceCANBrake READ getDeviceCANBrake WRITE setDeviceCANBrake NOTIFY deviceCANBrakeChanged)
    Q_PROPERTY(int deviceTestAccel READ getDeviceTestAccel WRITE setDeviceTestAccel NOTIFY deviceTestAccelChanged)
    Q_PROPERTY(int deviceEVIC READ getDeviceEVIC WRITE setDeviceEVIC NOTIFY deviceEVICChanged)
    Q_PROPERTY(int deviceAdaBlue READ getDeviceAdaBlue WRITE setDeviceAdaBlue NOTIFY deviceAdaBlueChanged)
    Q_PROPERTY(int deviceThinkBMS READ getDeviceThinkBMS WRITE setDeviceThinkBMS NOTIFY deviceThinkBMSChanged)
    Q_PROPERTY(int devicePIDListen READ getDevicePIDListen WRITE setDevicePIDListen NOTIFY devicePIDListenChanged)
    Q_PROPERTY(int deviceELM327Emu READ getDeviceELM327Emu WRITE setDeviceELM327Emu NOTIFY deviceELM327EmuChanged)

public:
    BLEHandler();
    ~BLEHandler();

    //All the getter/setter methods for the above properties that were defined for QML use:
    QString getBLEStatus();
    int getTimeRunning();
    float getRequestedTorque() const;
    float getActualTorque() const;
    int getRawThrottle1() const;
    int getRawThrottle2() const;
    int getRawBrake() const;
    int getPercThrottle() const;
    int getPercBrake() const;
    int getRequestedRPM() const;
    int getActualRPM() const;
    int getPowerMode() const;
    void setPowerMode(const int newMode);
    int getGear() const;
    bool getIsRunning() const;
    bool getIsFaulted() const;
    bool getIsWarning() const;
    int getLogLevel() const;
    void setLogLevel(const int newLevel);
    int getSOC() const;
    float getBusVoltage() const;
    float getBusCurrent() const;
    float getMotorCurrent() const;
    float getKWH() const;    
    float getMechPower() const;
    quint32 getBitfield1() const;
    quint32 getBitfield2() const;
    quint32 getDigitalInputs() const;
    quint32 getDigitalOutputs() const;
    float getMotorTemp() const;
    float getInverterTemp() const;
    float getSysTemp() const;
    int getPrechargeDuration() const;
    void setPrechargeDuration(const int newVal);
    int getPrechargeOutput() const;
    void setPrechargeOutput(const int newVal);
    int getMainContactorOutput() const;
    void setMainContactorOutput(const int newVal);
    int getCoolingOutput() const;
    void setCoolingOutput(const int newVal);
    int getCoolingOnTemp() const;
    void setCoolingOnTemp(const int newVal);
    int getCoolingOffTemp() const;
    void setCoolingOffTemp(const int newVal);
    int getBrakeLightOutput() const;
    void setBrakeLightOutput(const int newVal);
    int getReverseLightOutput() const;
    void setReverseLightOutput(const int newVal);
    int getEnableMotorControlInput() const;
    void setEnableMotorControlInput(const int newVal);
    int getReverseInput() const;
    void setReverseInput(const int newVal);
    int getNumThrottleADC() const;
    void setNumThrottleADC(const int newVal);
    int getThrottleType() const;
    void setThrottleType(const int newVal);
    int getThrottle1Min() const;
    void setThrottle1Min(const int newVal);
    int getThrottle2Min() const;
    void setThrottle2Min(const int newVal);
    int getThrottle1Max() const;
    void setThrottle1Max(const int NewVal);
    int getThrottle2Max() const;
    void setThrottle2Max(const int newVal);
    int getRegenMaxPedalPos() const;
    void setRegenMaxPedalPos(const int newVal);
    int getRegenMinPedalPos() const;
    void setRegenMinPedalPos(const int newVal);
    int getFWDMotionPedalPos() const;
    void setFWDMotionPedalPos(const int newVal);
    int getMapPedalPos() const;
    void setMapPedalPos(const int newVal);
    int getRegenThrottleMin() const;
    void setRegenThrottleMin(const int newVal);
    int getRegenThrottleMax() const;
    void setRegenThrottleMax(const int newVal);
    int getCreepThrottle() const;
    void setCreepThrottle(const int newVal);
    int getBrakeMinADC() const;
    void setBrakeMinADC(const int newVal);
    int getBrakeMaxADC() const;
    void setBrakeMaxADC(const int newVal);
    int getRegenBrakeMin() const;
    void setRegenBrakeMin(const int newVal);
    int getRegenBrakeMax() const;
    void setRegenBrakeMax(const int newVal);
    float getNominalVoltage() const;
    void setNominalVoltage(const int newVal);
    int getMaxRPM() const;
    void setMaxRPM(const int newVal);
    int getMaxTorque() const;
    void setMaxTorque(const int newVal);

    int getDeviceDMOC() const;
    void setDeviceDMOC(const int newVal);
    int getDeviceBrusaDMC5() const;
    void setDeviceBrusaDMC5(const int newVal);
    int getDeviceCodaUQM() const;
    void setDeviceCodaUQM(const int newVal);
    int getDeviceCKInverter() const;
    void setDeviceCKInverter(const int newVal);
    int getDeviceTestInverter() const;
    void setDeviceTestInverter(const int newVal);
    int getDeviceBrusaCharger() const;
    void setDeviceBrusaCharger(const int newVal);
    int getDeviceTCCH() const;
    void setDeviceTCCH(const int newVal);
    int getDeviceLearCharger() const;
    void setDeviceLearCharger(const int newVal);
    int getDevicePotAccel() const;
    void setDevicePotAccel(const int newVal);
    int getDevicePotBrake() const;
    void setDevicePotBrake(const int newVal);
    int getDeviceCANAccel() const;
    void setDeviceCANAccel(const int newVal);
    int getDeviceCANBrake() const;
    void setDeviceCANBrake(const int newVal);
    int getDeviceTestAccel() const;
    void setDeviceTestAccel(const int newVal);
    int getDeviceEVIC() const;
    void setDeviceEVIC(const int newVal);
    int getDeviceAdaBlue() const;
    void setDeviceAdaBlue(const int newVal);
    int getDeviceThinkBMS() const;
    void setDeviceThinkBMS(const int newVal);
    int getDevicePIDListen() const;
    void setDevicePIDListen(const int newVal);
    int getDeviceELM327Emu() const;
    void setDeviceELM327Emu(const int newVal);

signals:
    void bleStatusChanged();
    void timeRunningChanged();
    void reqTorqueChanged();
    void actTorqueChanged();
    void rawThrottle1Changed();
    void rawThrottle2Changed();
    void rawBrakeChanged();
    void percThrottleChanged();
    void percBrakeChanged();
    void reqRPMChanged();
    void actRPMChanged();
    void powerModeChanged();
    void gearChanged();
    void isRunningChanged();
    void isFaultedChanged();
    void isWarningChanged();
    void logLevelChanged();
    void SOCChanged();
    void busVoltageChanged();
    void busCurrentChanged();
    void motorCurrentChanged();
    void kilowattHoursChanged();
    void mechPowerChanged();
    void bitField1Changed();
    void bitField2Changed();
    void digitalInputsChanged();
    void digitalOutputsChanged();
    void motorTemperatureChanged();
    void inverterTemperatureChanged();
    void systemTemperatureChanged();
    void prechargeDurationChanged();
    void prechargeOutputChanged();
    void mainContactorOutputChanged();
    void coolingOutputChanged();
    void coolingOnTempChanged();
    void coolingOffTempChanged();
    void brakeLightOutputChanged();
    void reverseLightOutputChanged();
    void enableMotorControlInputChanged();
    void reverseInputChanged();
    void numThrottleADCChanged();
    void throttleTypeChanged();
    void throttle1MinChanged();
    void throttle2MinChanged();
    void throttle1MaxChanged();
    void throttle2MaxChanged();
    void regenMaxPedalPosChanged();
    void regenMinPedalPosChanged();
    void fwdMotionPedalPosChanged();
    void mapPedalPosChanged();
    void regenThrottleMinChanged();
    void regenThrottleMaxChanged();
    void creepThrottleChanged();
    void brakeMinADCChanged();
    void brakeMaxADCChanged();
    void regenBrakeMinChanged();
    void regenBrakeMaxChanged();
    void nomBattVoltsChanged();
    void maxRPMChanged();
    void maxTorqueChanged();

    void deviceDMOCChanged();
    void deviceBrusaDMC5Changed();
    void deviceCodaUQMChanged();
    void deviceCKInverterChanged();
    void deviceTestInverterChanged();
    void deviceBrusaChargerChanged();
    void deviceTCCHChanged();
    void deviceLearChargerChanged();
    void devicePotAccelChanged();
    void devicePotBrakeChanged();
    void deviceCANAccelChanged();
    void deviceCANBrakeChanged();
    void deviceTestAccelChanged();
    void deviceEVICChanged();
    void deviceAdaBlueChanged();
    void deviceThinkBMSChanged();
    void devicePIDListenChanged();
    void deviceELM327EmuChanged();

public slots:
    void deviceSearch();
    void connectToService(const QString &address);
    void disconnectService();
    QString deviceAddress() const;
    int numDevices() const;

private slots:
    //QBluetothDeviceDiscoveryAgent
    void addDevice(const QBluetoothDeviceInfo&);
    void scanFinished();
    void deviceScanError(QBluetoothDeviceDiscoveryAgent::Error);

    //QLowEnergyController
    void serviceDiscovered(const QBluetoothUuid &);
    void serviceScanDone();
    void controllerError(QLowEnergyController::Error);
    void deviceConnected();
    void deviceDisconnected();


    //QLowEnergyService
    void serviceStateChanged(QLowEnergyService::ServiceState s);
    void updateBLECharacteristic(const QLowEnergyCharacteristic &c,
                              const QByteArray &value);
    void confirmedDescriptorWrite(const QLowEnergyDescriptor &d,
                              const QByteArray &value);
    void serviceError(QLowEnergyService::ServiceError e);

private:
    QBluetoothDeviceDiscoveryAgent *discoveryAgent;
    BLEDeviceInfo currentDevice;
    QLowEnergyDescriptor bleDescriptor;
    QList<QObject*> bleDevices;
    bool foundGEVCUService;
    QLowEnergyController *bleController;
    QLowEnergyService *bleService;
    bool okToWrite;

    //local store of all public properties values
    QString m_bleStatus;
    int m_timeRunning;
    int m_reqTorque;
    int m_actTorque;
    int m_rawThrottle1;
    int m_rawThrottle2;
    int m_rawBrake;
    int m_percThrottle;
    int m_percBrake;
    int m_reqRPM;
    int m_actRPM;
    int m_powerMode;
    int m_gear;
    bool m_isRunning;
    bool m_isFaulted;
    bool m_isWarning;
    int m_SOC;
    int m_logLevel;
    int m_busVoltage;
    int m_busCurrent;
    int m_motorCurrent;
    int m_kilowattHours;
    int m_mechPower;
    quint32 m_bitField1;
    quint32 m_bitField2;
    quint32 m_digitalInputs;
    quint32 m_digitalOutputs;
    int m_motorTemperature;
    int m_inverterTemperature;
    int m_systemTemperature;
    int m_prechargeDuration;
    int m_prechargeOutput;
    int m_mainContactorOutput;
    int m_coolingOutput;
    int m_coolingOnTemp;
    int m_coolingOffTemp;
    int m_brakeLightOutput;
    int m_reverseLightOutput;
    int m_enableMotorControlInput;
    int m_reverseInput;
    int m_numThrottleADC;
    int m_throttleType;
    int m_throttle1Min;
    int m_throttle2Min;
    int m_throttle1Max;
    int m_throttle2Max;
    int m_regenMaxPedalPos;
    int m_regenMinPedalPos;
    int m_fwdMotionPedalPos;
    int m_mapPedalPos;
    int m_regenThrottleMin;
    int m_regenThrottleMax;
    int m_creepThrottle;
    int m_brakeMinADC;
    int m_brakeMaxADC;
    int m_regenBrakeMin;
    int m_regenBrakeMax;
    int m_nomBattVolts;
    int m_maxRPM;
    int m_maxTorque;
    quint32 m_devicesEnabled;

    void interpretCharacteristic3101(const quint8 *data);
    void interpretCharacteristic3102(const quint8 *data);
    void interpretCharacteristic3103(const quint8 *data);
    void interpretCharacteristic3104(const quint8 *data);
    void interpretCharacteristic3105(const quint8 *data);
    void interpretCharacteristic3106(const quint8 *data);
    void interpretCharacteristic3107(const quint8 *data);
    void interpretCharacteristic3108(const quint8 *data);
    void interpretCharacteristic3109(const quint8 *data);
    void interpretCharacteristic310A(const quint8 *data);
    void interpretCharacteristic310B(const quint8 *data);
    void interpretCharacteristic310C(const quint8 *data);
    void interpretCharacteristic310D(const quint8 *data);
    void interpretCharacteristic310E(const quint8 *data);
    void interpretCharacteristic31D0(const quint8 *data);

    void sendCharacteristic3105();
    void sendCharacteristic3109();
    void sendCharacteristic310A();
    void sendCharacteristic310B();
    void sendCharacteristic310C();
    void sendCharacteristic310D();
    void sendCharacteristic310E();
};

#endif // BLEHANDLER_H
