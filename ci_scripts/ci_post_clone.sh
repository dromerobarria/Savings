#!/bin/sh

#  ci_post_clone.sh
#  Saving
#
#  Created by Daniel Romero on 26-07-24.
#  

install_or_update_swiftlint_if_needed() {
    echo "Install SwiftLint"
    brew install swiftlint
    swiftlint $CI_WORKSPACE
    return 0
}

install_or_update_swiftlint_if_needed
