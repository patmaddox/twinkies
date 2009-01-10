require File.dirname(__FILE__) + '/spec_helper'

describe DateTime, "#pretty" do
  it "should print 'Day, dd Mon 2009 01:23:45" do
    DateTime.parse('1/9/2009 3:45pm').pretty.
      should == 'Fri, 09 Jan 2009 15:45:00'
  end
end
