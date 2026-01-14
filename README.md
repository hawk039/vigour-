# Vigour - Daily Quote App

A modern Flutter application for daily inspiration, built with a clean MVVM architecture and Supabase integration.

## Features

- **Supabase Authentication**: Secure Signup, Login, and Password Reset flow.
- **Quote of the Day**: Daily inspiration delivered to your home screen.(not fully integrated)
- **Explore Feed**: Browse through 100+ curated quotes across categories like Motivation, Zen, and Wisdom.
- **Cloud Favorites**: Save your favorite quotes to your account, synced across devices.
- **Social Sharing**: Generate beautiful quote cards and share them directly to social media(need a bit polishing).
- **Clean Architecture**: Built using Provider for state management and Repository pattern for data handling.

## Tech Stack

- **Flutter**: UI Framework
- **Supabase**: Backend (Auth & Database)
- **Provider**: State Management
- **Hive**: Local caching
- **Share Plus & Screenshot**: For quote card generation and sharing

## Setup

1. Clone the repository.
2. Run `flutter pub get`.
3. Create a Supabase project and run the provided SQL scripts (found in documentation) to set up the `quotes` and `favorites` tables.
4. Update `lib/core/constants.dart` with your Supabase URL and Anon Key.
5. Run `flutter run`.


## Design and Development Insights from a Full Stack Developer
https://www.loom.com/share/24fdec99219e4569b8213cf70b002020
Hi, this is Mayank dhyani, and in this video, I share my experience as a full stack and mobile application developer,
highlighting my design process using Stitch and Gemini. I discuss how I created the app's design, including my choices for color palettes and themes,
ultimately opting for a light theme for better appeal. I also touch on my current use of Android Studio for development, as I'm transitioning to a new role.
Please take a look at the design showcase I provide, and I welcome any feedback or thoughts you may have.


## debugging with AI
https://www.loom.com/share/04ec80db9dca4c619355abe71a009356
In this video, I share my approach to bug fixing with AI, 
emphasizing the importance of identifying the main line causing the error rather than relying on the entire stack trace. 
I typically rely on AI for about 50-60% of the debugging process, 
but I prefer to handle the actual debugging myself because it's my favorite part of coding. 
I explain that simply copying and pasting error messages into AI can lead to confusion and wasted time, 
so I recommend providing the specific line causing the issue instead. My goal is to highlight how combining AI with manual debugging can effectively resolve issues. 
I encourage viewers to adopt this method for more efficient debugging.

## Leveraging AI for Efficient Coding Workflows
https://www.loom.com/share/0336f2ad354a41b0b566a8ac482bea91
In this video, I share my current AI workflow using Gemini within Android Studio, where I rely on AI for about 70% of my coding tasks. 
I emphasize the importance of having a clear architecture, such as MVVM, and selecting the right tools for API calls and state management. 
I also discuss my approach to structuring the UI in an atomic manner to maintain code manageability as the project scales. While I leverage AI for coding, 
I always review the output to ensure it meets best practices and avoids performance issues. I encourage you to consider how you can integrate similar AI strategies into 
your own development process.

## Note on Demo Submission & Workflow Context
Hello
Brewapps Recruitment team,
I wanted to share a quick note to provide some context around my submission.
The reset password flow and the “quote of the day” notification feature are partially implemented. Due to interview timelines and limited available time, 
I focused on completing the core architecture and primary user flows first, while leaving these two features in a half-complete state rather than rushing an unreliable implementation.
Regarding the app demo video, I wasn’t able to include it in the Loom recordings. My MacBook Pro has been facing system and memory limitations, which made screen recording unstable while running the app and backend services simultaneously.
That said, I’d like to highlight one important aspect of my workflow:
I actively and effectively use AI as a productivity multiplier across both frontend and backend development. This includes API design, data modeling, edge-case handling, and iterative refinement rather than one-shot generation.
You can review my Python & FastAPI backend work, including AI-integrated logic, at the following link:
https://github.com/hawk039/kahani-backend
I believe this demonstrates not just feature implementation, but how I think about building scalable systems efficiently under real-world constraints.
Thank you for your time and consideration.

Best regards,
Mayank Dhyani
