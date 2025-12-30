{ issueName }:
let
  issues = {
    cardiel = ''\e[1;32mTake some Anvil. Charge it.

\e[1;33m~ \e[1;35m ALL HAIL CARDIEL!\e[0m (\l)

    '';
    shri = ''\e[1;32mYoga is a big misnomer in the west, people don’t know what this yoga is.

Yoga means UNION with the divine.

When you become one with the divine, the divine starts flowing through you and you become part and parcel of the whole.

\e[1;33m~ \e[1;35mH.H. Shri Mataji Nirmala Devi - 1984\e[0m (\l)

    '';
    turing = ''\e[1;32m

Hyperboloids of wondrous light
Rolling for age through Space and Time
Harbour there Waves which somehow Might
Play out God’s holy pantomime

\e[1;33m~ \e[1;35mAlan Turing\e[0m (\l)

    '';
    wordsworth = ''\e[1;32mOf Newton, with his prism and silent face.

The marble index of a mind forever Voyaging through Strange Seas of thought, alone.

\e[1;33m~\e[1;35m William Wordsworth - The Prelude, Book 3\e[0m (\l)

    '';
    judy = ''\e[1;32mSomewhere over the rainbow, skies are blue, and the dreams that you dare to dream really do come true.

\e[1;33m~ \e[1;35mJudy Garland\e[0m (\l)

    '';
    penny = ''\e[1;32mLife is a dream come true.

\e[1;33m~ \e[1;35mTom Penny\e[0m (\l)

    '';
  };
in
  {
    environment.etc."issue".text = issues.${issueName};
  }
