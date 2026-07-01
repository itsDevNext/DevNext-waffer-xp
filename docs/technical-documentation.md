# Waffer XP
# Technical Documentation

## Project Overview
With Waffer XP, saving money becomes an engaging and motivating experience by combining financial goal tracking with gamification techniques. Users create savings goals, monitor their progress through interactive progress bars, earn XP by reaching milestones, unlock achievement badges, and complete weekly challenges that encourage consistent saving habits. Rather than simply tracking money, Waffer XP is designed to help users maintain motivation, recover from setbacks, and build long-term financial discipline through positive reinforcement.

## Technology Stack
•	Flutter (Cross-platform Mobile Development)
•	Dart (Programming language used to write the code for Flutter applications)
•	Supabase (Serverless, open-source backend platform)
•	Figma (UI Design tool)
•	PostgreSQL Database (Open-source object-relational database system)
•	Flutter Lottie (JSON-based animation file)

## System Architecture
The system follows a client-server architecture where the Flutter mobile application communicates with Supabase for user authentication, data storage and management, and real-time synchronization.
Main Components
•	Authentication Module
•	User Profile Module
•	Savings Goal Management Module
•	Progress Tracking Module
•	XP & Level System Module
•	Achievement & Badge System Module
•	Challenge Management Module
•	Notification Module



## System Workflow
The application follows the workflow below to guide users through the saving experience:
1.	User creates an account or logs in. 
2.	User creates a savings goal by entering a target amount and deadline. 
3.	User adds savings toward the goal. 
4.	The system updates the progress bar and completion percentage. 
5.	When a milestone is reached, the system awards XP and updates the user's level. 
6.	Completed challenges unlock achievements and badges. 
7.	The dashboard displays the user's latest savings progress, XP balance, level, active challenges, and earned achievements. 

Workflow/Activity Diagram

<img width="468" height="1200" alt="mermaid-diagram-2026-06-30-181554" src="https://github.com/user-attachments/assets/5040f7f4-e1b3-4c1b-ac29-8a9f90a093ca" />

## Core Features
o	User Authentication
Users can securely create an account and log in using Supabase Authentication.

o	Savings Goals
Users create savings goals by defining:
	Goal name
	Target amount
	Deadline

o	Progress Tracking
The application visualizes savings progress using interactive progress bars, completion percentages, milestone indicators, and goal completion status, allowing users to clearly monitor their financial journey.

o	Gamification System
The application rewards positive financial behaviour using:
	XP Points for reaching savings milestones
	Level progression to reward consistent saving behaviour
	Achievement badges for completing financial goals
	Saving streaks that encourage regular contributions
	Weekly challenges that promote short-term saving habits

o	Dashboard
The dashboard provides users with:
	Current savings progress
	Active challenges
	XP balance
	Current level
	Earned achievements
	Upcoming milestones

o	Database Design
	users
Stores user account information.
	savings_goals
Stores savings targets, deadlines, and saved amounts.
	challenges
Stores available saving challenges.
	achievements
Stores badges and unlocked achievements.
	user_progress
Tracks savings progress, XP, and current level.
	user_challenges
Tracks challenge completion for each user.
	notifications
Stores reminder and achievement notifications.

## Behavioural Design
The application applies behavioural design principles identified during user research by encouraging consistent saving habits through positive reinforcement instead of punishment. Progress bars, XP rewards, milestone celebrations, and weekly challenges are designed to sustain motivation, while achievement badges recognize long-term devotion to financial goals. The system stresses gradual progress, helping users recover from temporary setbacks without discouraging future participation.

## Future Enhancements
	Open Banking integration
	Personalized AI saving recommendations
	Community leaderboards
	Automatic savings suggestions
	Financial wellness score
	Social saving groups
	Smart milestone notifications

## Conclusion
Waffer XP combines financial goal management with behavioural design and gamification to encourage consistent saving habits. By integrating progress tracking, XP rewards, achievements, challenges, and milestone-based feedback, the application transforms saving into an engaging experience while promoting long-term financial discipline. The proposed architecture also provides a scalable foundation for future enhancements such as AI recommendations, Open Banking integration, and personalized financial coaching.
