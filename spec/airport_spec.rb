require 'airport'

describe Airport do

  let(:plane) {double :plane}
  let(:plane2) {double :plane2}

  describe '#land' do

    it {is_expected.to respond_to(:land).with(1).argument}

    it 'lands plane' do
      plane = double(:plane, :ground => false)
      allow(subject).to receive(:bad_weather?).and_return false
      subject.land(plane)
      expect(subject.planes).to eq [plane]
    end

    it 'prevents landing when weather is stormy' do
      plane = double(:plane, :ground => false)
      allow(subject).to receive(:bad_weather?).and_return true
      expect{subject.land(plane)}.to raise_error "Ach no, there's a storm a-brewin'!"
    end

    it 'prevents landing when airport is full' do
      plane = double(:plane, :ground => false)
      allow(subject).to receive(:bad_weather?).and_return false
      Airport::DEFAULT_CAPACITY.times {subject.land(plane)}
      expect{subject.land(plane)}.to raise_error "Sorry, we've got more planes that you can shake a stick at."
    end

    it 'planes cannot land if they are already at the airport'

    it 'planes cannot land if they have landed at another airport'

  end

  describe '#take_off' do

    it {is_expected.to respond_to(:take_off).with(1).argument}

    it 'planes instructed to take off and leaves airport' do
      plane = double(:plane, :ground => false, :fly => true)
      plane2 = double(:plane2, :ground => false)
      allow(subject).to receive(:bad_weather?).and_return false
      subject.land(plane)
      subject.land(plane2)
      subject.take_off(plane)
      expect(subject.planes).to eq [plane2]
    end

    it 'planes cannot take off when weather is stormy' do
      plane = double(:plane, :ground => false, :fly => true)
      allow(subject).to receive(:bad_weather?).and_return false
      subject.land(plane)
      allow(subject).to receive(:bad_weather?).and_return true
      expect{subject.take_off(plane)}.to raise_error "Ach no, there's a storm a-brewin'!"
    end

    it 'planes can only take off if they are landed'

    it 'planes can only take off from aiport they are in'

  end

  it 'sets airport capacity' do
    airport = Airport.new(2)
    expect(airport.capacity).to eq 2
  end

end
