class ActiveModelTemplate
  # ActiveAttr::Model
  #   includes from ActiveAttr:
  #     ActiveAttr::BasicModel
  #     ActiveAttr::Attributes
  #     ActiveAttr::AttributeDefaults
  #     ActiveAttr::QueryAttributes
  #     ActiveAttr::Typecasting
  #     ActiveAttr::TypecastedAttributes
  #     ActiveAttr::Logger
  #     ActiveAttr::ChainableInitialization
  #     ActiveAttr::BlockInitialization
  #     ActiveAttr::MassAssignment
  #     ActiveAttr::MassAssignmentSecurity
  #   includes from ActiveModel:
  #     ActiveModel::Naming
  #     ActiveModel::AttributeMethods
  #     ActiveModel::Conversion
  #     ActiveModel::Validations
  #     ActiveModel::Translation
  #     ActiveModel::MassAssignmentSecurity
  #     ActiveModel::Serialization
  #     ActiveModel::Serializers::JSON
  #     ActiveModel::Serializers::Xml
  include ActiveAttr::Model
  include ActiveModel::Dirty
  extend  ActiveModel::Callbacks

  #### ATTRIBUTES ####

  attribute :model_length,                                  :type => Integer, :default => "Some title"

  attr_reader :errors

  #### VALIDATIONS ####



  #### CALLBACKS ####

  # Provides before, around, and after callbacks for create
  define_model_callbacks :create, :validation

  before_validation do

  end

  after_validation do

  end

  before_create do

  end

  after_create do

  end

  #### METHODS ####

  def initialize(*)
    super
    @errors = ActiveModel::Errors.new(self)
  end

  def create
    if valid?
      run_callbacks :create do
        # Your create action methods here
        true
      end
    else
      false
    end
  end

  def persisted?
    false
  end

  protected

  def run_validations!
    run_callbacks :validation do
      run_callbacks :validate
      errors.empty?
    end
  end

end

