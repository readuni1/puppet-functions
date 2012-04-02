#
# merge.rb
#
# Copyright 2011 Puppet Labs Inc.
# Copyright 2011 Krzysztof Wilczynski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Puppet::Parser::Functions
  newfunction(:merge, :type => :rvalue, :doc => <<-EOS
Returns

Prototype:

    merge()

Where

For example:

  Given the following statements:

  The result will be as follows:

    EOS
  ) do |*arguments|
    #
    # This is to ensure that whenever we call this function from within
    # the Puppet manifest or alternatively form a template it will always
    # do the right thing ...
    #
    arguments = arguments.shift if arguments.first.is_a?(Array)

    raise Puppet::ParseError, "merge(): Wrong number of arguments " +
      "given (#{arguments.size} for 2)" if arguments.size < 2

    this = arguments.shift

    raise Puppet::ParseError, 'merge(): First argument requires ' +
      'a hash type to work with' unless this.is_a?(Hash)

    other = arguments.shift

    raise Puppet::ParseError, 'merge(): Second argument requires ' +
      'a hash type to work with' unless other.is_a?(Hash)

    # We have to be compliant with Hash#merge merge priority ...
    this.merge(other)
  end
end

# vim: set ts=2 sw=2 et :
# encoding: utf-8
