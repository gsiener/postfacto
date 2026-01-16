/*
 * Postfacto, a free, open-source and self-hosted retro tool aimed at helping
 * remote teams.
 *
 * Copyright (C) 2016 - Present Pivotal Software, Inc.
 *
 * This program is free software: you can redistribute it and/or modify
 *
 * it under the terms of the GNU Affero General Public License as
 *
 * published by the Free Software Foundation, either version 3 of the
 *
 * License, or (at your option) any later version.
 *
 *
 *
 * This program is distributed in the hope that it will be useful,
 *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *
 * GNU Affero General Public License for more details.
 *
 *
 *
 * You should have received a copy of the GNU Affero General Public License
 *
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import React from 'react';
import * as PropTypes from 'prop-types';
import EmojiCategory from './EmojiCategory';
import {EMOJI_RANGES} from './emojiData';

/**
 * Main emoji selector component
 * Displays all emoji categories in a scrollable selector
 */
export default class EmojiSelector extends React.Component {
  static propTypes = {
    onSelect: PropTypes.func.isRequired,
  };

  // Expose ranges for backwards compatibility
  static ranges = EMOJI_RANGES;

  render() {
    const {onSelect} = this.props;

    return (
      <div className="emoji-selector">
        {EMOJI_RANGES.map(({name, values}) => (
          <EmojiCategory
            key={name}
            name={name}
            values={values}
            onSelect={onSelect}
          />
        ))}
      </div>
    );
  }
}
