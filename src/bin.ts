#!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning
import {commandCenter} from './index.js'
import process from 'node:process'

const bareargs = process.argv.slice(2)
commandCenter(bareargs.shift(), bareargs)
