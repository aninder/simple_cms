require 'rails_helper'

RSpec.describe Subject, type: :model do

  let(:valid_subject){Subject.new(:name=>"genetics",:position=>1)}
  let(:valid_subject2){Subject.new(:name=>"sumthing",:position=>2)}

  it "saves given valid subject" do
    expect{valid_subject.save}.to change{Subject.count}.by(1)
  end

  it "is invalid if the name is not given" do
    valid_subject.name = nil
    expect(Subject.new).not_to be_valid
  end

  it "is invalid if the name is empty" do
    valid_subject.name = ""
    expect(valid_subject).not_to be_valid
    expect(valid_subject.errors.keys).to include(:name)
  end

  it "is invalid if the lenght of name is less than 6" do
    valid_subject.name="12345"
    expect(valid_subject).not_to be_valid
    expect(valid_subject.errors.keys).to include(:name)
  end

  it "is valid for lenght between 6 and 20" do
    1000.times do
      valid_subject.name = (1..rand(1..5)).map { (rand(256)).chr }.join
      expect(valid_subject).not_to be_valid

      valid_subject.name = (1..rand(6..20)).map { (65 + rand(26)).chr }.join
      expect(valid_subject).to be_valid

      valid_subject.name= (1..rand(21..100)).map { (65 + rand(26)).chr }.join
      expect(valid_subject).not_to be_valid
    end
  end

  it "chomps off any spaces in the name at beg or end" do
    valid_subject.name=" 1234     "
    expect(valid_subject).not_to be_valid
  end

  it "to err if the position number is same" do
    valid_subject.position=3
    valid_subject2.position=3
    valid_subject.save
    expect(valid_subject2).not_to be_valid
    expect(valid_subject2.errors.keys).to include(:position)
  end

  it "errs if name is admin or superuser" do
    valid_subject.name="admin"
    expect(valid_subject).not_to be_valid

    valid_subject.name="superuser"
    expect(valid_subject).not_to be_valid
  end
end
