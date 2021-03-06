# Copyright (C) 2013 Kyle Johnson <kyle@vacantminded.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

def weechat_init
  Weechat.register 'querymon', 'Kabaka',
    '0.2', 'MIT', 'Query Monitor', '', ''

  Weechat.hook_print '', '', '', 0,
    'print_hook', ''

  @buffer = Weechat.buffer_new 'QueryMon',
    '', '', '', ''

  Weechat.buffer_set @buffer,
    'title', 'Query Monitor'

  Weechat::WEECHAT_RC_OK
end

def print_hook data, buffer, date, tags,
  displayed, highlight, prefix, message
  
  unless Weechat.buffer_get_string(buffer, 'plugin') == 'irc'
    return Weechat::WEECHAT_RC_OK
  end

  network, name = Weechat.buffer_get_string(buffer, 'name').split '.'

  if network == 'server' or Weechat.info_get('irc_is_channel', "#{network},#{name}") == '1'
    return Weechat::WEECHAT_RC_OK
  end

  Weechat.print @buffer,
    "#{prefix}\t#{message}"

  Weechat::WEECHAT_RC_OK
end

