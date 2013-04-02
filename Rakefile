#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

require File.expand_path('../lib/khan', __FILE__)
require 'json'

Ludum::Application.load_tasks

desc "reset position for all sections and subsection"
task reset_positions: :environment do
  Course.find(:all).each do |course|
    ap "\n\ncourse:\n#{course.title}\n"
    course.sections.each_with_index do |section, i|
      section.position = i + 1
      section.save
      ap "\nsection:\n#{section.title}"
      section.subsections.each_with_index do |sub, i2|
        sub.position = i2 + 1
        sub.save
        ap "subsection:\n#{sub.title}"
        sub.questions.each_with_index do |q, i3|
          q.position = i3+1
          q.save
        end
      end
    end
  end
end

