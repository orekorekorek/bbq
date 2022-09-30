require 'rails_helper'

RSpec.describe EventPolicy do
  subject { described_class }

  let(:user) { FactoryBot.create(:user) }
  let(:alien) { FactoryBot.create(:user) }

  let(:event) { FactoryBot.create(:event, user:) }
  let(:event_with_pincode) { FactoryBot.create(:event, user:, pincode: '123') }

  permissions :show? do
    context 'when event has no pincode' do
      let(:event_context) { EventContext.new(event:, user:, pincode: nil) }

      context 'when user is owner' do
        it { is_expected.to permit(user, event_context) }
      end

      context 'when user is not owner' do
        it { is_expected.to permit(alien, event_context) }
      end

      context 'when user is not authorized' do
        it { is_expected.to permit(nil, event_context) }
      end
    end

    context 'when event has pincode' do
      let(:event_context) { EventContext.new(event: event_with_pincode, user:, pincode: nil) }

      context 'and user is owner' do
        it { is_expected.to permit(user, event_context) }
      end

      context 'and pincode is nil/wrong' do
        context 'and user is not owner' do
          it { is_expected.not_to permit(alien, event_context) }
        end

        context 'and user is unauthorized' do
          it { is_expected.not_to permit(nil, event_context) }
        end
      end

      context 'and pincode is correct' do
        let(:event_context) { EventContext.new(event: event_with_pincode, user:, pincode: '123') }

        context 'and user is not owner' do
          it { is_expected.to permit(alien, event_context) }
        end

        context 'and user is unauthorized' do
          it { is_expected.to permit(nil, event_context) }
        end
      end
    end
  end

  permissions :edit? do
    context 'when user is owner' do
      it { is_expected.to permit(user, event) }
    end

    context 'when user is not owner' do
      it { is_expected.not_to permit(alien, event) }
    end

    context 'when user is not authorized' do
      it { is_expected.not_to permit(nil, event) }
    end
  end

  permissions :destroy? do
    context 'when user is owner' do
      it { is_expected.to permit(user, event) }
    end

    context 'when user is not owner' do
      it { is_expected.not_to permit(alien, event) }
    end

    context 'when user is not authorized' do
      it { is_expected.not_to permit(nil, event) }
    end
  end

  permissions :update? do
    context 'when user is owner' do
      it { is_expected.to permit(user, event) }
    end

    context 'when user is not owner' do
      it { is_expected.not_to permit(alien, event) }
    end

    context 'when user is not authorized' do
      it { is_expected.not_to permit(nil, event) }
    end
  end
end
