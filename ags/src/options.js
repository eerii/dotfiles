/**
 * An object holding Options that are Variables with cached values.
 *
 * to update an option at runtime simply run
 * ags -r "options.path.to.option.setValue('value')"
 *
 * resetting:
 * ags -r "options.reset()"
 */

import { Option, resetOptions, getValues, apply, getOptions } from './settings/options.js';
import { USER } from 'resource:///com/github/Aylur/ags/utils.js';

export default {
    reset: resetOptions,
    values: getValues,
    apply: apply,
    list: getOptions,

    spacing: Option(9),
    padding: Option(8),
    radii: Option(9),

    color: {
        red: Option('#e55f86', { 'scss': 'red' }),
        green: Option('#00D787', { 'scss': 'green' }),
        yellow: Option('#EBFF71', { 'scss': 'yellow' }),
        blue: Option('#51a4e7', { 'scss': 'blue' }),
        magenta: Option('#9077e7', { 'scss': 'magenta' }),
        teal: Option('#51e6e6', { 'scss': 'teal' }),
        orange: Option('#E79E64', { 'scss': 'orange' }),
    }, 
};
