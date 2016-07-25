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
public:
    BLEHandler();
    ~BLEHandler();

signals:

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
    //void updateHeartRateValue(const QLowEnergyCharacteristic &c,
               //               const QByteArray &value);
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
};

#endif // BLEHANDLER_H
