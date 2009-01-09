require File.dirname(__FILE__) + '/spec_helper'
require 'ostruct'

module Twinkies
  describe UrlList do
    it "should find a url from a string" do
      UrlList.new('http://foo').should include('http://foo')
    end

    it "should find a url from a list" do
      UrlList.new('http://foo', 'http://bar').
        should include('http://foo', 'http://bar')
    end

    it "should find a url from an array" do
      UrlList.new(['http://foo', 'http://bar']).
        should include('http://foo', 'http://bar')
    end

    it "should find a url from a string with extra chars" do
      UrlList.new('I like http://foo !!').should include('http://foo')
    end

    it "should not find extra characters" do
      UrlList.new('I like http://foo !!').
        should_not include('I', 'like')
    end

    it "should find multiple urls from a single string" do
      UrlList.new('here: http://foo & http://bar').
        should include('http://foo', 'http://bar')
    end

    it "should have the enumerable methods" do
      UrlList.new('http://foo http://bar', 'http://baz').
        map.should == ['http://foo', 'http://bar', 'http://baz']
    end

    describe "working with objects instead of strings" do
      it "should get the strings based on a block" do
        tweet = OpenStruct.new(:text => 'http://foo http://bar')
        UrlList.new(tweet) {|t| t.text }.
          should == [{:item => tweet, :url => 'http://foo'},
                     {:item => tweet, :url => 'http://bar'}]
      end
    end
  end
end
