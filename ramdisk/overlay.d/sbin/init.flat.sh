#!/system/bin/sh

echo "PRIO=1,1,1,1,0,0,0,0
# arch_timer,arch_mem_timer,arm-pmu,kgsl-3d0
IGNORED_IRQ=19,22,39,209" > /dev/msm_irqbalance.conf
chmod 644 /dev/msm_irqbalance.conf
mount --bind /dev/msm_irqbalance.conf /vendor/etc/msm_irqbalance.conf
chcon "u:object_r:vendor_configs_file:s0" /vendor/etc/msm_irqbalance.conf
