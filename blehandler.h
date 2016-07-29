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
    Q_PROPERTY(int timeRunning READ getTimeRunning NOTIFY timeRunningChanged)
    Q_PROPERTY(float reqTorque READ getRequestedTorque NOTIFY reqTorqueChanged)
    Q_PROPERTY(float actTorque READ getActualTorque NOTIFY actTorqueChanged)
    Q_PROPERTY(int rawThrottle READ getRawThrottle NOTIFY rawThrottleChanged)
    Q_PROPERTY(int rawBrake READ getRawBrake NOTIFY rawBrakeChanged)
    Q_PROPERTY(int reqRPM READ getRequestedRPM NOTIFY reqRPMChanged)
    Q_PROPERTY(int actRPM READ getActualRPM NOTIFY actRPMChanged)
    Q_PROPERTY(int powerMode READ getPowerMode WRITE setPowerMode NOTIFY powerModeChanged)
    Q_PROPERTY(int gear READ getGear NOTIFY gearChanged)
    Q_PROPERTY(bool isRunning READ getIsRunning NOTIFY isRunningChanged)
    Q_PROPERTY(bool isFaulted READ getIsFaulted NOTIFY isFaultedChanged)
    Q_PROPERTY(bool isWarning READ getIsWarning NOTIFY isWarningChanged)
    Q_PROPERTY(int logLevel READ getLogLevel WRITE setLogLevel NOTIFY logLevelChanged)
    Q_PROPERTY(float busVoltage READ getBusVoltage NOTIFY busVoltageChanged)
    Q_PROPERTY(float busCurrent READ getBusCurrent NOTIFY busCurrentChanged)
    Q_PROPERTY(float motorCurrent READ getMotorCurrent NOTIFY motorCurrentChanged)
    Q_PROPERTY(float kilowattHours READ getKWH NOTIFY kilowattHoursChanged)
    Q_PROPERTY(float mechPower READ getMechPower NOTIFY mechPowerChanged)
    Q_PROPERTY(quint32 bitField1 READ getBitfield1 NOTIFY bitField1Changed)
    Q_PROPERTY(quint32 bitField2 READ getBitfield2 NOTIFY bitField2Changed)
    Q_PROPERTY(quint32 bitField3 READ getBitfield3 NOTIFY bitField3Changed)
    Q_PROPERTY(quint32 bitField4 READ getBitfield4 NOTIFY bitField4Changed)
    Q_PROPERTY(float motorTemperature READ getMotorTemp NOTIFY motorTemperatureChanged)
    Q_PROPERTY(float inverterTemperature READ getInverterTemp NOTIFY inverterTemperatureChanged)
    Q_PROPERTY(float systemTemperature READ getSysTemp NOTIFY systemTemperatureChanged)
    Q_PROPERTY(int prechargeR READ getPrechargeR WRITE setPrechargeR NOTIFY prechargeRChanged)
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

public:
    BLEHandler();
    ~BLEHandler();

    //All the getter/setter methods for the above properties that were defined for QML use:
    int getTimeRunning();
    float getRequestedTorque() const;
    float getActualTorque() const;
    int getRawThrottle() const;
    int getRawBrake() const;
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
    float getBusVoltage() const;
    float getBusCurrent() const;
    float getMotorCurrent() const;
    float getKWH() const;
    float getMechPower() const;
    quint32 getBitfield1() const;
    quint32 getBitfield2() const;
    quint32 getBitfield3() const;
    quint32 getBitfield4() const;
    float getMotorTemp() const;
    float getInverterTemp() const;
    float getSysTemp() const;
    int getPrechargeR() const;
    void setPrechargeR(const int newVal);
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

signals:
    void timeRunningChanged();
    void reqTorqueChanged();
    void actTorqueChanged();
    void rawThrottleChanged();
    void rawBrakeChanged();
    void reqRPMChanged();
    void actRPMChanged();
    void powerModeChanged();
    void gearChanged();
    void isRunningChanged();
    void isFaultedChanged();
    void isWarningChanged();
    void logLevelChanged();
    void busVoltageChanged();
    void busCurrentChanged();
    void motorCurrentChanged();
    void kilowattHoursChanged();
    void mechPowerChanged();
    void bitField1Changed();
    void bitField2Changed();
    void bitField3Changed();
    void bitField4Changed();
    void motorTemperatureChanged();
    void inverterTemperatureChanged();
    void systemTemperatureChanged();
    void prechargeRChanged();
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

    //local store of all public properties values
    int m_timeRunning;
    float m_reqTorque;
    float m_actTorque;
    int m_rawThrottle;
    int m_rawBrake;
    int m_reqRPM;
    int m_actRPM;
    int m_powerMode;
    int m_gear;
    bool m_isRunning;
    bool m_isFaulted;
    bool m_isWarning;
    int m_logLevel;
    float m_busVoltage;
    float m_busCurrent;
    float m_motorCurrent;
    float m_kilowattHours;
    float m_mechPower;
    quint32 m_bitField1;
    quint32 m_bitField2;
    quint32 m_bitField3;
    quint32 m_bitField4;
    float m_motorTemperature;
    float m_inverterTemperature;
    float m_systemTemperature;
    int m_prechargeR;
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
    void interpretCharacteristic31D0(const quint8 *data);

    void sendCharacteristic3105();
    void sendCharacteristic3109();
    void sendCharacteristic310A();
    void sendCharacteristic310B();
    void sendCharacteristic310C();
    void sendCharacteristic310D();
};

#endif // BLEHANDLER_H
