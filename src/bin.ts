#!/usr/bin/env -S node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning
import {knevee} from './index.ts'

knevee().executable()
