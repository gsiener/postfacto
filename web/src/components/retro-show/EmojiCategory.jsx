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
import EmojiButton from './EmojiButton';
import { fromCodePoints } from './emojiData';

/**
 * Emoji category section component
 * Renders a category header and all emojis within that category
 */
const EmojiCategory = ({ name, values, onSelect }) => {
  return (
    <div className="emoji-selector-group">
      <h1>{name}</h1>
      {values.map((points) => {
        const emoji = fromCodePoints(points);
        return (
          <EmojiButton
            key={emoji}
            emoji={emoji}
            onSelect={onSelect}
          />
        );
      })}
    </div>
  );
};

EmojiCategory.propTypes = {
  name: PropTypes.string.isRequired,
  values: PropTypes.arrayOf(
    PropTypes.oneOfType([
      PropTypes.number,
      PropTypes.arrayOf(PropTypes.number),
    ])
  ).isRequired,
  onSelect: PropTypes.func.isRequired,
};

export default EmojiCategory;
