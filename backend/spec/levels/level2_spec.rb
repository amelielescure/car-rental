require 'spec_helper'

describe 'Level 2' do
	describe '#new' do
		before(:all) do
			LevelTwo.new
		end

		include_examples 'Levels', 'app/levels/level2'
	end
end