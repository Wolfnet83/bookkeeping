class CreateRegularFeesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # Regular.
  end
end
