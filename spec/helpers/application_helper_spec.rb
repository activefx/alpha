require 'spec_helper'

describe ApplicationHelper do

  describe "#flash_messages" do

    context "when there is no flash messages" do

      it "returns nothing" do
        helper.flash_messages.should be_nil
      end

    end

    context "when there is one flash message" do

      let(:flashes) do
        { :error => 'Error!' }
      end

      before do
        flashes.each { |type, message| flash[type] = message }
      end

      subject { helper.flash_messages }

      it "renders one flash message" do
        should have_selector('div.alert.alert-error', :text => "Error!")
        should have_selector("a") # close link
      end

    end

    context "when there are multiple flash message" do

      let(:flashes) do
        { :error => 'Error!',
          :warning => 'Warning!',
          :success => 'Success!',
          :info => 'Info' }
      end

      before do
        flashes.each { |type, message| flash[type] = message }
      end

      subject { helper.flash_messages }

      it "renders a list with flash messages" do
        flashes.each do |type, message|
          should have_selector("div.alert.alert-#{type}", :text => message)
          should have_selector("a") # close link
        end
      end

    end

    context "when using alert and notice flashes" do

      let(:flashes) do
        { :notice => 'Notice!',
          :alert => 'Alert!' }
      end

      before do
        flashes.each { |type, message| flash[type] = message }
      end

      subject { helper.flash_messages }

      it "converts to the appropriate css class" do
        flashes.each do |type, message|
          flash_type = case type.to_s
                       when "notice" then "info"
                       when "alert" then "warning"
                       end
          should have_selector("div.alert.alert-#{flash_type}", :text => message)
          should have_selector("a") # close link
        end
      end

    end


  end

end

