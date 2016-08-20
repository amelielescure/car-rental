RSpec.shared_examples 'Levels' do |path|
	let(:path) { path }

	context 'with a valid data source' do
		let(:expected_data) { JsonFileHelper.read_json("#{path}/output.json") }
		let(:generated_data) { JsonFileHelper.read_json("#{path}/myoutput.json") }

		it 'generates data output not be nil' do
			expect(generated_data).not_to be_nil
		end

		it 'generates a level file with items' do
			expect(generated_data).not_to be_empty
		end

		it 'generates an identical file' do
			expect(generated_data).to eq expected_data
		end
	end
end