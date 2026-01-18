module.exports = {
  content: [
    './app/views/**/*.{erb,html}',
    './app/helpers/**/*.rb',
  ],
  theme: {
    extend: {
      colors: {
        happy: '#51c0b1',
        meh: '#fec722',
        sad: '#e34e40',
        action: '#f2eee2',
      },
    },
  },
  plugins: [],
}
