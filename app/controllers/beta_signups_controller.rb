class BetaSignupsController < ApplicationController

  layout "landing_page"

  skip_before_filter :show_beta_page?

  def index
    if referred_by_code = (params[:referred_by] || params[:fb_ref])
      @referred_by = BetaSignup.where(:referral_code => referred_by_code).first
      unless @referred_by.nil? # are they using a valid referral code?
        @referred_by.update_attribute(:clicks, (@referred_by.clicks + 1) )
      end
      @beta_signup = BetaSignup.new(:referred_by => referred_by_code)
    else
      @beta_signup = BetaSignup.new
    end
  end



#  Thanks! Want to get an early invitation?

#  Invite at least 3 friends using the link below. The more friends you invite, the sooner you’ll get access!

#  To share with your friends, click "Share" and "Tweet":

#  Tweet
#  Or copy and paste the following link to share wherever you want!


#  Welcome back!

#  Your live stats: 0 clicks, 0 sign ups

#  The more friends you invite, the sooner you’ll get access!

#  To share with your friends, click "Share" and "Tweet"

#  Tweet
#  Or copy and paste the following link to share wherever you want!

  def create
    respond_to do |format|
      if @beta_signup = BetaSignup.where(:email => params[:beta_signup][:email]).first
        @beta_count = BetaSignup.where(:referred_by => @beta_signup.referral_code).count
        @beta_clicks = @beta_signup.clicks
        flash.now.notice = "Welcome back!"
        format.html { redirect_to beta_signups_path(:thanks => "welcome_back"), :notice => <<-DELIM
Welcome back!
We will contact you as soon as invites become available. You currently have
#{@beta_signup.clicks} click#{"s" unless @beta_signup.clicks == 1} and
#{@beta_count} referral#{"s" unless @beta_count == 1}!
To gain earlier access, keep sharing this link:
<p>#{@beta_signup.short_url}</p>
DELIM
}
        format.js
      else
        @beta_signup = BetaSignup.new(params[:beta_signup])
        if @beta_signup.save
          flash.now.notice = "Thanks, we've added you to the list!"
          format.html { redirect_to beta_signups_path(:thanks => "added"), :notice => <<-DELIM
Thanks, we've added you to the list!
We will contact you as soon as invites become available.
To get earlier access, share this referral link with your friends:
<p>#{@beta_signup.short_url}</p>
DELIM
}
          format.js
        else
          if !@beta_signup.errors[:email].empty?
            flash.now.alert = "Please enter a valid email address."
          else
            flash.now.alert = "There was a problem, please try again."
          end
          format.html { render :action => :index }
          format.js
        end
      end
    end
  end

#  # GET /beta_signups
#  # GET /beta_signups.json
#  def index
#    @beta_signups = BetaSignup.all

#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @beta_signups }
#    end
#  end

#  # GET /beta_signups/1
#  # GET /beta_signups/1.json
#  def show
#    @beta_signup = BetaSignup.find(params[:id])

#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @beta_signup }
#    end
#  end

#  # GET /beta_signups/new
#  # GET /beta_signups/new.json
#  def new
#    @beta_signup = BetaSignup.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @beta_signup }
#    end
#  end

#  # GET /beta_signups/1/edit
#  def edit
#    @beta_signup = BetaSignup.find(params[:id])
#  end

#  # POST /beta_signups
#  # POST /beta_signups.json
#  def create
#    @beta_signup = BetaSignup.new(params[:beta_signup])

#    respond_to do |format|
#      if @beta_signup.save
#        format.html { redirect_to @beta_signup, notice: 'Beta signup was successfully created.' }
#        format.json { render json: @beta_signup, status: :created, location: @beta_signup }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @beta_signup.errors, status: :unprocessable_entity }
#      end
#    end
#  end

#  # PUT /beta_signups/1
#  # PUT /beta_signups/1.json
#  def update
#    @beta_signup = BetaSignup.find(params[:id])

#    respond_to do |format|
#      if @beta_signup.update_attributes(params[:beta_signup])
#        format.html { redirect_to @beta_signup, notice: 'Beta signup was successfully updated.' }
#        format.json { head :ok }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @beta_signup.errors, status: :unprocessable_entity }
#      end
#    end
#  end

#  # DELETE /beta_signups/1
#  # DELETE /beta_signups/1.json
#  def destroy
#    @beta_signup = BetaSignup.find(params[:id])
#    @beta_signup.destroy

#    respond_to do |format|
#      format.html { redirect_to beta_signups_url }
#      format.json { head :ok }
#    end
#  end
end

