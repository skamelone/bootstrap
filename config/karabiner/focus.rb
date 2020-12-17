#!/usr/bin/env ruby

# You can generate json by executing the following command on Terminal.
#
# $ ruby ./dafuk.rb
#

# Parameters

def parameters
  {
    :simultaneous_threshold_milliseconds => 500,
    :trigger_key => 'f',
  }
end

############################################################

require 'json'

def main
  data = {
    'title' => 'Focus Mode',
    'rules' => [
      {
        'description' => 'Focus Mode',
        'manipulators' => [
          generate_launcher_mode('i', [], [{ 'key_code' => "open_bracket", 'modifiers' => ["right_command", "right_shift"] }]),
          generate_launcher_mode('o', [], [{ 'key_code' => "close_bracket", 'modifiers' => ["right_command", "right_shift"] }]),
          generate_launcher_mode('h', [], [{ 'key_code' => "spacebar", 'modifiers' => ["right_control"] }, {'key_code' => 'h'}]),
          generate_launcher_mode('l', [], [{ 'key_code' => "spacebar", 'modifiers' => ["right_control"] }, {'key_code' => 'l'}]),
          generate_launcher_mode('j', [], [{ 'key_code' => "spacebar", 'modifiers' => ["right_control"] }, {'key_code' => 'j'}]),
          generate_launcher_mode('k', [], [{ 'key_code' => "spacebar", 'modifiers' => ["right_control"] }, {'key_code' => 'k'}]),
          generate_launcher_mode('x', [], [{ 'key_code' => "spacebar", 'modifiers' => ["right_control"] }, {'key_code' => 'x'}]),
          generate_launcher_mode('y', [], [{ 'key_code' => "spacebar", 'modifiers' => ["right_control"] }, {'key_code' => 'y'}]),


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
        'name' => 'dafuck_mode',
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
        'key_up_when' => 'any',
        'to_after_key_up' => [
          {
            'set_variable' => {
              'name' => 'dafuck_mode',
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
          'name' => 'dafuck_mode',
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
