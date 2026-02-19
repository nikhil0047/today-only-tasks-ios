# Today-Only Todo App

A minimal iOS task manager built with a single guiding constraint:

The app only cares about today.

Tasks belong to the current day, expire automatically, and each new day starts with a clean slate.

This constraint simplifies decision-making, reduces cognitive load, and encourages daily focus.

# Core Principles

Tasks belong only to today

Tasks expire automatically at day end

No backlog, overdue tasks, or future scheduling

New day → fresh start

# Features
## Today-Only Tasks

Add tasks for the current day

Tasks from previous days are not shown

Tasks can optionally expire later the same day

## Task Interaction

Add a task

Mark a task as complete

Smooth animations & haptic feedback

Expired tasks disappear automatically

## Automatic Day Reset

When a new day begins, the list resets

No manual cleanup required

## Offline-First

All data stored locally using Core Data

No network dependency

## Architecture

This project uses MVVM (Model–View–ViewModel).

Structure
Model
 └── TaskEntity (Core Data)

ViewModel
 └── TaskListViewModel
     • business logic
     • filtering & expiration
     • persistence handling

Views
 ├── ContentView
 ├── TaskRowView
 └── EmptyStateView

Business Logic
Today Filtering

Tasks are filtered using the start of the current day:

createdAt >= startOfDay


This ensures older tasks are automatically hidden.

Expiration Logic

Tasks with expiration times are filtered:

expiresAt > currentTime


Expired tasks disappear automatically.

Daily Reset

Instead of deleting tasks at midnight, the app filters tasks by date.
This ensures a clean slate every day without background jobs.

## Technical Decisions
Why MVVM?

Separation of UI and business logic

Easier testing

Improved scalability

Why Core Data?

Required iOS 16 compatibility

Reliable offline persistence

Production-ready solution

Why Filter Instead of Delete?

Filtering tasks by date:

✔ avoids background scheduling
✔ prevents accidental data loss
✔ improves reliability
✔ simplifies logic

# Tradeoffs
## Old tasks remain in storage

They are hidden, not deleted.

Why?

safer data handling

avoids accidental loss

simplifies midnight logic

Optional cleanup could be added later.

# Core Data adds boilerplate

Chosen for reliability and iOS 16 support.

SwiftData would simplify code but requires iOS 17.

# Testing

Unit tests verify:

only today’s tasks appear

expired tasks are filtered

completion state updates

task creation logic

## What I Would Improve With More Time
## User Experience

progress indicator for daily completion

subtle completion celebration animation

swipe gestures for faster interaction

accessibility enhancements

# Smart Features

local notifications before task expiration

end-of-day reminder summary

home screen widget

# Data Management

optional auto-cleanup of old tasks

export or daily summary feature

# Technical Improvements

repository layer for cleaner dependency injection

performance optimization for large datasets

UI snapshot testing

widget extension support

# Future Enhancements

Apple Watch companion

Focus mode integration

Siri shortcuts (“Add task for today”)

Daily productivity insights

# Getting Started

Clone the repository

Open in Xcode

Build & run on iOS 16+

# Requirements

iOS 16+

Xcode 15+
