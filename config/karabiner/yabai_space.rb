#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./yabai.rb
#

# Parameters

def parameters
  {
    :simultaneous_threshold_milliseconds => 500,
    :trigger_key => 'semicolon',
  }
end

############################################################

require 'json'

def main
  data = {
    'title' => 'Yabai Focus Space',
    'rules' => [
      {
        'description' => 'Yabai Focus Space',
        'manipulators' => [
          generate_launcher_mode('a', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 1" }]),
          generate_launcher_mode('s', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 2" }]),
          generate_launcher_mode('d', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 3" }]),
          generate_launcher_mode('f', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 4" }]),
          generate_launcher_mode('g', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 5" }]),
          generate_launcher_mode('h', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 6" }]),
          generate_launcher_mode('j', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 7" }]),
          generate_launcher_mode('k', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 8" }]),
          generate_launcher_mode('l', [], [{ 'shell_command' => "/usr/local/bin/yabai -m space --focus 9" }]),
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
        'name' => 'yabai_focus_space_mode',
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
              'name' => 'yabai_focus_space_mode',
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
          'name' => 'yabai_focus_space_mode',
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
