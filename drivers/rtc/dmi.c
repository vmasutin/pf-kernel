/*
 * RTC driver DMI matching.
 *
 *   Most machines using the mc146818 RTC need RTC_ALWAYS_BCD set to 1.
 *   This file does DMI matching for the tiny number (1 so far!) of machines
 *   that don't fit that mould.
 *
 *   (C) 2012 Nigel Cunningham <nigel@nigelcunningham.com.au>
 *	Add support for checking for the Sony Vaio VPCSE15FG.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
 *
 * Trademarks are the property of their respective owners.
 */

#include <linux/module.h>
#include <linux/dmi.h>

static const struct dmi_system_id __initconst nonbcd_dmi_table[] = {
#if defined(CONFIG_DMI) && defined(CONFIG_X86)
	{
		/* Sony VAIO VPCSE15FG */
		.matches = {
			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
			DMI_MATCH(DMI_PRODUCT_NAME, "VPCSE15FG"),
		},
	},
#endif
	{ }
};

bool rtc_check_always_bcd(void)
{
	static int printed;

	if (dmi_check_system(nonbcd_dmi_table)) {
		if (!printed) {
			printk("Non BCD RTC clock detected via DMI check.\n");
			printed = true;
		}
		return false;
	}
	return true;
}
EXPORT_SYMBOL_GPL(rtc_check_always_bcd);
