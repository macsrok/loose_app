# Loose

A modern Slack-like chat application built with Ruby on Rails 8.
I built this app so that I could practice implimenting the Solid Trifecta of technologies introduced in Rails 8. It has a few rough edges but I built it in a day so that is to be expected.

# Demo
I have deployed the application to an Oracle Cloud instance using Kamal 2.
You can visit it at https://loose.joesim.ms

## Features

### Team Communication
- Real-time messaging using Turbo Streams
- Support for both text messages and image uploads
- Create multiple chat rooms for different teams or topics
- Real-time updates when messages are sent/received

### User Management
- User authentication and authorization
- User profiles with avatar support
- Account settings management
- Secure password handling

### Room Management
- Create and manage multiple chat rooms
- Add/remove participants from rooms
- Track participant counts
- Real-time updates when participants join/leave

### Modern UI/UX
- Clean, responsive interface using Tailwind CSS
- Real-time updates without page refreshes
- Image upload previews
- Auto-expanding message input
- Modern landing page for non-authenticated users

## Technical Stack

- **Ruby Version**: 3.3.0
- **Rails Version**: 8.0.1
- **Framework**: Ruby on Rails 8
- **Frontend**: 
  - Turbo for real-time updates
  - Stimulus.js for interactive UI components
  - Tailwind CSS for styling
- **Storage**: Active Storage for image handling
- **Performance**: View caching for optimized rendering
- **Asset Pipeline**: Propshaft

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```
3. Setup the database:
   ```bash
   rails db:create db:migrate
   ```
4. Start the server:
   ```
   bin/dev
   ```
5. Visit `http://localhost:3000` in your browser

## Development

The application uses:
- Modern browser features for optimal performance
- Import maps for JavaScript

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
