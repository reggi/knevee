#!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning
import {Command} from '../Command.ts'

Command.dirSubprocess()
