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

class MockGoogleClient
  MOCK_TOKEN_PREFIX = 'expected-valid-access-token_'.freeze

  def get_user!(access_token)
    unless access_token.start_with?(MOCK_TOKEN_PREFIX)
      raise GoogleClient::GetUserFailed.new
    end

    # Extract email suffix from token to match frontend mock behavior
    # Token format: "expected-valid-access-token_<email-prefix>"
    # Returns email as "<email-prefix>@example.com"
    email_prefix = access_token.sub(MOCK_TOKEN_PREFIX, '')
    email = "#{email_prefix}@example.com"
    {
      name: 'Test User',
      email: email,
      hd: 'example.com'
    }
  end
end
