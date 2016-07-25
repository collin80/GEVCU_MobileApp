#include <qbluetoothuuid.h>
#include "bledeviceinfo.h"

BLEDeviceInfo::BLEDeviceInfo():
    QObject()
{
}

QBluetoothDeviceInfo BLEDeviceInfo::getDevice() const
{
    return m_device;
}

QString BLEDeviceInfo::getAddress() const
{
#ifdef Q_OS_MAC
    // workaround for Core Bluetooth:
    return m_device.deviceUuid().toString();
#else
    return m_device.address().toString();
#endif
}

void BLEDeviceInfo::setDevice(const QBluetoothDeviceInfo &device)
{
    m_device = device;
    emit deviceChanged();
}
