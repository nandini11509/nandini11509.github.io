# BeatBlend

BeatBlend is a Flutter app designed to enhance the clubbing experience by allowing club members to recommend songs to the DJ and influence the music played based on financial contributions.

## Features

- **Recommend Songs:** Users can recommend songs of their choice to the DJ.
- **Financial Contributions:** Each song recommendation requires a monetary contribution.
- **Collective Influence:** Songs with higher collective contributions are more likely to be played by the DJ.
- **Firebase Integration:** Backend services such as user authentication, database management, and real-time updates are powered by Firebase.
- **Engaging User Experience:** Create a vibrant and interactive musical environment where club members actively participate in curating the playlist.

## Video of App
https://drive.google.com/file/d/1YzVBX7djnYOYH7RC1rk7gjwhIevKYITU/view?usp=sharing


## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/nandini11509/clubmusic
   ```

2. Set up Firebase:

    - Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).
    - Add your Flutter app to the Firebase project.
    - Follow the instructions to download the `google-services.json` file and place it in the appropriate location in your Flutter project.

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Firebase Setup

The app relies on Firebase for the following functionalities:

- **Authentication:** Users can sign in/sign up using Firebase Authentication.
- **Database:** Firebase Firestore is used to store user data, song recommendations, and contribution amounts.
- **Real-time Updates:** Firebase Firestore provides real-time updates to ensure dynamic and synchronized data across devices.

Make sure to configure Firebase correctly by following the setup instructions provided in the Firebase Console.


---

