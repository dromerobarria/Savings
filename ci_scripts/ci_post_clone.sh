#!/bin/sh

#  ci_post_clone.sh
#  Saving
#
#  Created by Daniel Romero on 26-07-24.
#  

brew install swiftlint
echo "SwiftLint install"
swiftlint $CI_WORKSPACE
