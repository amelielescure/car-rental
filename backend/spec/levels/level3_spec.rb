require 'spec_helper'

describe 'Level 3' do
  describe '#new' do
    before(:all) do
      LevelThree.run
    end

		include_examples 'Levels', 'app/levels/level3'
	end
end
