require File.dirname(__FILE__) + '/spec_helper'

module Twinkies
  describe Item do
    describe "created" do
      before(:each) do
        @tweet = Twitter::Status.new
        @tweet.id = 123
        @tweet.text = "hello mang!"
        @tweet.created_at = DateTime.parse('7/24/1985')
        @user = Twitter::User.new
        @user.screen_name = 'padillac'
        @tweet.user = @user
        @item = Item.create :tweet => @tweet, :link => "http://foo"
      end

      it "should get the twitter ID from the tweet id" do
        @item.twitter_id.should == 123
      end

      it "should get the text from the tweet" do
        @item.text.should == "hello mang!"
      end

      it "should get the screen name from the tweet" do
        @item.user.should == 'padillac'
      end

      it "should get the date from the tweet" do
        @item.created_at.should == DateTime.parse('7/24/1985')
      end

      describe "created with the same twitter ID" do
        it "should return existing record if URLs are the same" do
          i = Item.create :tweet => @tweet, :link => "http://foo"
          i.should == @item
        end

        it "should return existing record if URLs are same (and when there's one different)" do
          exist = Item.create :tweet => @tweet, :link => "http://bar"
          i = Item.create :tweet => @tweet, :link => "http://bar"
          i.should == exist
        end

        it "should create a new item if URLs are different" do
          i = Item.create :tweet => @tweet, :link => "http://bar"
          i.should_not == @item
        end
      end
    end
  end
end
