#
# Postfacto, a free, open-source and self-hosted retro tool aimed at helping
# remote teams.
#
# Copyright (C) 2016 - Present Pivotal Software, Inc.
#
# This program is free software: you can redistribute it and/or modify
#
# it under the terms of the GNU Affero General Public License as
#
# published by the Free Software Foundation, either version 3 of the
#
# License, or (at your option) any later version.
#
#
#
# This program is distributed in the hope that it will be useful,
#
# but WITHOUT ANY WARRANTY; without even the implied warranty of
#
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#
# GNU Affero General Public License for more details.
#
#
#
# You should have received a copy of the GNU Affero General Public License
#
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
require 'configurations/redis_configuration_provider'
require 'climate_control'

describe RedisConfigurationProvider do
  let(:subject) { RedisConfigurationProvider.new }

  describe '#redis_config' do
    around do |example|
      ClimateControl.modify('RAILS_ENV' => rails_env, 'REDIS_URL' => redis_url) do
        example.run
      end
    end

    context 'when running outside of production' do
      let(:rails_env) { 'development' }
      let(:redis_url) { 'redis://user:pass@hostname.com:420' }

      it 'is nil' do
        expect(subject.redis_config).to be_nil
      end
    end

    context 'when running in production' do
      let(:rails_env) { 'production' }

      context 'when REDIS_URL is defined in the environment' do
        let(:redis_url) { 'redis://user:pass@hostname.com:420' }

        it 'returns the url from REDIS_URL' do
          expect(subject.redis_config).to eq('redis://user:pass@hostname.com:420')
        end
      end

      context 'when REDIS_URL is not defined in the environment' do
        let(:redis_url) { nil }

        it 'returns nil' do
          expect(subject.redis_config).to be_nil
        end
      end
    end
  end
end
