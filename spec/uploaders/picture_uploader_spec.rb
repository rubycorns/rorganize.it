require 'spec_helper'

describe PictureUploader do
  it 'includes protection against malicious uploads' do
    expect(subject.class.ancestors).to include(CarrierWave::BombShelter)
  end
end
