#!/usr/bin/env ruby
# frozen_string_literal: true

require 'i3ipc'
require 'open3'

i3 = I3Ipc::Connection.new

workspaces = i3.workspaces

def x(wks, val)
  Open3.popen3('eww', 'update', "#{wks}=#{val}") { |_, _, _, _| }
  # system("eww update #{wks}=#{val}")
end

workspaces.each do |ws|
  ws.focused ? x("ws#{ws.name}", 'focus') : x("ws#{ws.name}", '')
end

block = proc do |reply|
  if reply.change == 'focus'
    x("ws#{reply.old.name}", '')
    x("ws#{reply.current.name}", 'focus')
  end

  reply.change == 'empty' && x("ws#{reply.current.name}", 'empty')
  reply.change == 'init' && x("ws#{reply.current.name}", '')
end

pid = i3.subscribe('workspace', block)
pid.join

i3.close
