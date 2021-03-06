require 'spec_helper'

describe Incidents::Notifications::Role, :type => :model do
  it "retrieves its shift members" do
    shift = FactoryGirl.create :shift_with_positions
    person = FactoryGirl.create :person, chapter: shift.county.chapter, counties: [shift.county], positions: shift.positions
    shift.shift_groups.first.update_attributes start_offset: 0, end_offset: 86400
    FactoryGirl.create :shift_assignment, shift: shift, person: person, date: person.chapter.time_zone.today
    role = FactoryGirl.create :notification_role, shifts: [shift], chapter: person.chapter

    expect(role.shift_members).to match_array([person])
  end

  it "retrieves its position members" do
    person = FactoryGirl.create :person
    role = FactoryGirl.create :notification_role, positions: [person.positions.first], chapter: person.chapter

    expect(role.position_members).to match_array([person])
  end
end
