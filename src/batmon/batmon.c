/*
 * http://github.com/mitchweaver/bin
 *
 * monitor battery level on OpenBSD
 * and send desktop notification when low
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <util.h>
#include <fcntl.h>
#include <machine/apmvar.h>
#include <sys/ioctl.h>

int
bperc()
{
    int fd;
    fd = open("/dev/apm", O_RDONLY);
    if (fd < 0)
        return 0;

    struct apm_power_info info;
    memset(&info, 0, sizeof(struct apm_power_info));
    ioctl(fd, APM_IOC_GETPOWER, &info);
    close(fd);

    return info.battery_life;
}

int
main()
{
    char buf[512];
    int perc;

    while (1) {
        perc = bperc();
        if(perc < 20) {
            if (perc < 5)
                sprintf(buf, "notify-send -u critical 'Battery level CRITICAL: %d%%'\n", perc);
            else if (perc < 10)
                sprintf(buf, "notify-send -u critical 'Battery level urgent: %d%%'\n", perc);
            else
                sprintf(buf, "notify-send 'Battery level low: %d%%'\n", perc);
            system(buf);
        }
        sleep(300);
    }
    return 0;
}
