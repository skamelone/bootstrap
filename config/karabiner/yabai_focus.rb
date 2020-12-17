#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./yabai.rb
#

# Parameters

def parameters
  {
    :simultaneous_threshold_milliseconds => 500,
    :trigger_key => 'w',
  }
end

############################################################

require 'json'

def main
  data = {
    'title' => 'Yabai Focus',
    'rules' => [
      {
        'description' => 'Yabai Focus',
        'manipulators' => [
          generate_launcher_mode('h', [], [{ 'shell_command' => "/usr/local/bin/yabai -m window --focus west" }]),
          generate_launcher_mode('l', [], [{ 'shell_command' => "/usr/local/bin/yabai -m window --focus east" }]),
          generate_launcher_mode('j', [], [{ 'shell_command' => "/usr/local/bin/yabai -m window --focus south" }]),
          generate_launcher_mode('k', [], [{ 'shell_command' => "/usr/local/bin/yabai -m window --focus north" }]),
          generate_launcher_mode('f', [], [{ 'shell_command' => "/usr/local/bin/yabai -m window --toggle native-fullscreen" }]),

        ].flatten,
      },
    ],
  }

  puts JSON.pretty_generate(data)
end

def generate_launcher_mode(from_key_code, mandatory_modifiers, to)
  data = []

  ############################################################

  h = {
    'type' => 'basic',
    'from' => {
      'key_code' => from_key_code,
      'modifiers' => {
        'mandatory' => mandatory_modifiers,
        'optional' => [
          'any',
        ],
      },
    },
    'to' => to,
    'conditions' => [
      {
        'type' => 'variable_if',
        'name' => 'yabai_focus_mode',
        'value' => 1,
      },
    ],
  }

  data << h

  ############################################################

  h = {
    'type' => 'basic',
    'from' => {
      'simultaneous' => [
        {
          'key_code' => parameters[:trigger_key],
        },
        {
          'key_code' => from_key_code,
        },
      ],
      'simultaneous_options' => {
        'detect_key_down_uninterruptedly' => true,
        'key_down_order' => 'strict',
        'key_up_order' => 'strict_inverse',
        'key_up_when' => 'all',
        'to_after_key_up' => [
          {
            'set_variable' => {
              'name' => 'yabai_focus_mode',
              'value' => 0,
            },
          },
        ],
      },
      'modifiers' => {
        'mandatory' => mandatory_modifiers,
        'optional' => [
          'any',
        ],
      },
    },
    'to' => [
      {
        'set_variable' => {
          'name' => 'yabai_focus_mode',
          'value' => 1,
        },
      },
    ].concat(to),
    'parameters' => {
      'basic.simultaneous_threshold_milliseconds' => parameters[:simultaneous_threshold_milliseconds],
    },
  }

  data << h

  ############################################################

  data
end

main
