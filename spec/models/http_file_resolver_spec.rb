require 'spec_helper'

describe Riiif::HTTPFileResolver do
  subject { Riiif::HTTPFileResolver.new }

  before do
    subject.id_to_uri = lambda {|id| id}
  end

  it "should raise an error when the file isn't found" do
    expect(Kernel).to receive(:open).and_raise(OpenURI::HTTPError.new("failure", StringIO.new))
    begin
      subject.find('1234')
    rescue Riiif::ImageNotFoundError => e
    end
    expect(e).to be_a Riiif::ImageNotFoundError
    expect(e.original_exception).to be_an OpenURI::HTTPError
  end
end

