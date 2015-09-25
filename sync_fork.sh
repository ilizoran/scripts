#!/bin/bash
git fetch upstream
git checkout rel-5_0
git merge upstream/rel-5_0
