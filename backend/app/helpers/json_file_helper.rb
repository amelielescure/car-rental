class JsonFileHelper
  def self.read_json file
    file = File.read(file)
    JSON.parse(file)
  end

  def self.generate_json data
    File.open('myoutput.json', 'w') do |f|
      f.write( JSON.pretty_generate(data) )
    end
  end
end