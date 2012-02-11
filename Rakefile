#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Eve::Application.load_tasks

namespace :csv do
  desc "generate a csv containing skill levels of all characters"
  task :skills => :environment do
    YAML::ENGINE.yamler = 'syck'
    
    
    
    # first line
    skills="Type Name, Type ID"
    Character.all.each do |char|
      skills = "#{skills},#{char.name}"
    end
    skills = "#{skills}\n"
    
    # all skills
    print "Fetching skill tree..."
    STDOUT.flush
    api = Eve::API.new
    skill_tree = api.eve.skill_tree
    puts "done"
    
    total = skill_tree.skill_groups.count
    skill_tree.skill_groups.each_with_index do |skill_group, i|
      # skill_group.group_id, skill_group.group_name
      percent = (((i+1.0)/total)*100).to_i
      percent = " #{percent.to_s}" if percent<10
      print "\r\e[0KProcessing skill tree [#{percent}%]..."
      STDOUT.flush
      skill_group.skills.each do |skill|
        # skill.description, skill.group_id, skill.published, skill.rank, skill.required_attributes, skill.type_id, skill.type_name, skill.required_skills, skill.skill_bonus_collection
        skills = "#{skills}#{skill.type_name},#{skill.type_id}"
        Character.all.each do |char|
          charskill = char.api.character.character_sheet.skills.select{|f| f.type_id == skill.type_id}.first
          level = 0
          level = charskill.level unless charskill.nil?
          skills = "#{skills},#{level}"
        end
        skills = "#{skills}\n"
      end
    end
    puts "done"
    
    print "Writing to file..."
    STDOUT.flush
    csv_path = File.join(File.dirname(__FILE__),'public','csv','skills.csv')
    csv = File.open csv_path, 'w'
    csv.puts(skills)
    csv.close
    puts "done"
  end
  
  desc "generate a csv containing standings of all characters"
  task :standings do
    # csv_path = File.join(File.dirname(__FILE__),'public','csv','standings.csv')
    # standings=""
    # 
    # 
    # 
    # csv = File.open csv_path, 'w'
    # csv.puts(standings)
    # csv.close
  end
end