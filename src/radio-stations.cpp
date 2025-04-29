#include "radio-stations.hpp"

#define SONGS(_station) (_station ## _songs), sizeof(_station ## _songs)/sizeof(struct song_info_t)

static struct song_info_t radio_summit2025_songs[] = {
  { "Shay", "Sans Coeur", 2024 },
  { "Ultrafox", "Dancing with tears in my Eyes", 2024 },
  { "Pink Floyd", "On the Run", 2024 },
  { "Talking Heads", "Once in a Lifetime", 2024 },
  { "Nirvana", "About a Girl", 2024 },
  { "Placebo", "Running up that Hill", 2024 },
};

static struct song_info_t radio_los_santos_songs[] = {
  { "YG", "I'm A Real 1", 2013 },
  { "100s", "Life of a Mack", 2013 },
  { "Ab-Soul feat. Kendrick Lamar", "ILLuminate", 2012 },
  { "A$AP Rocky feat. Aston Matthews & Joey Fatts", "R-Cali", 2013 },
  { "Marion Band$ feat. Nipsey Hussle", "Hold Up", 2013 },
  { "BJ the Chicago Kid feat. Freddie Gibbs & Problem", "Smokin' and Ridin'", 2013 },
  { "Kendrick Lamar", "A.D.H.D", 2011 },
  { "Jay Rock feat. Kendrick Lamar", "Hood Gone Love It", 2011 },
  { "The Game feat. 2 Chainz & Rick Ross", "Ali Bomaye", 2012 },
  { "Freddie Gibbs", "Still Livin'", 2012 },
  { "DJ Esco feat. Future", "How It Was", 2013 },
  { "Problem feat. Glasses Malone", "Say That Then", 2013 },
  { "Clyde Carson feat. The Team", "Slow Down", 2012 },
  { "Gucci Mane feat. Ciara", "Too Hood", 2011 },
  { "Gangrene", "Bassheads", 2013 },
  { "Danny Brown & Action Bronson", "Bad News", 2013 },
  { "G-Side feat. G-Mane", "Relaxin'", 2010 },
  { "A$AP Ferg", "Work", 2013 },
  { "Trouble feat. Gucci Mane", "Everyday", 2012 },
  { "Kendrick Lamar", "Swimming Pools, Drank", 2012 },
  { "Travi$ Scott feat. 2 Chainz & T.I.", "Upper Echelon", 2013 },
  { "Danny Brown feat. A$AP Rocky & Zelooperz", "Kush Coma", 2013 },
  { "Ace Hood feat. Future & Rick Ross", "Bugatti", 2013 },
  { "Schoolboy Q feat. Kendrick Lamar", "Collard Greens", 2013 },
  { "Chuck Inglish feat. Ab-Soul & Mac Miller", "Came Thru/Easily", 2013 },
  { "Young Scooter feat. Gucci Mane", "Work", 2013 },
  { "Problem & IamSu feat. Bad Lucc & Sage The Gemini", "Do It Big", 2013 },
  { "Skeme", "Millions", 2013 },
  { "Ab-Soul feat. Schoolboy Q", "Hunnid Stax", 2014 },
  { "Freddie Gibbs & Mike Dean", "Sellin' Dope", 2014 },
  { "Young Scooter feat. Trinidad James", "I Can't Wait", 2013 },
};

static struct song_info_t non_stop_pop_songs[] = {
 { "All Saints", "Pure Shores", 1999 },
 { "Britney Spears", "Gimme More", 2007 },
 { "Corona", "The Rhythm of the Night, Rapino Bros. 7'' Single", 1993 },
 { "Fergie feat. Ludacris", "Glamorous", 2006 },
 { "Hall & Oates", "Adult Education", 1983 },
 { "Jane Child", "Don't Wanna Fall In Love", 1990 },
 { "Kelly Rowland", "Work, Freemasons Remix", 2007 },
 { "Mis-Teeq", "Scandalous", 2003 },
 { "Modjo", "Lady, Hear Me Tonight", 2000 },
 { "N-Joi", "Anthem", 1990 },
 { "Pet Shop Boys", "West End Girls", 1985 },
 { "Rihanna", "Only Girl, In The World", 2010 },
 { "Robyn feat. Kleerup", "With Every Heartbeat", 2007 },
 { "Stardust", "Music Sounds Better With You", 1998 },
 { "Wham!", "Everything She Wants", 1984 },
 { "Amerie", "1 Thing", 2005 },
 { "Robert Howard & Kym Mazelle", "Wait", 1989 },
 { "Sly Fox", "Let's Go All the Way", 1985 },
 { "Taylor Dayne", "Tell It to My Heart", 1987 },
 { "Living In A Box", "Living In A Box", 1987 },
 { "INXS", "New Sensation", 1988 },
 { "Bobby Brown", "On Our Own", 1989 },
 { "Bronski Beat", "Smalltown Boy", 1984 },
 { "Naked Eyes", "Promises, Promises", 1983 },
 { "Simply Red", "Something Got Me Started, Hurley's House Mix", 1991 },
 { "Sneaker Pimps", "6 Underground", 1996 },
 { "Backstreet Boys", "I Want It That Way", 1999 },
 { "Jamiroquai", "Alright", 1996 },
 { "Morcheeba", "Tape Loop, Shortcheeba Mix", 1996 },
 { "Moloko", "The Time Is Now", 2000 },
 { "Gorillaz feat. De La Soul", "Feel Good Inc.", 2005 },
 { "Robbie Williams & Kylie Minogue", "Kids", 2000 },
 { "Dirty Vegas", "Days Go By", 2001 },
 { "Cassie", "Me & U", 2006 },
 { "Maroon 5 feat. Christina Aguilera", "Moves Like Jagger", 2011 },
 { "M.I.A.", "Bad Girls", 2012 },
 { "M83", "Midnight City", 2011 },
 { "Lady Gaga", "Applause", 2013 },
 { "Mike Posner", "Cooler Than Me", 2010 },
 { "Lorde", "Tennis Court", 2013 },
 { "The Black Eyed Peas", "Meet Me Halfway", 2009 },
 { "Real Life", "Send Me An Angel '89", 1989 },
};

static struct radio_station_info_t radio_stations[] = {
  { "Radio Los Santos", SONGS(radio_los_santos) },
  { "Non-Stop-Pop FM", SONGS(non_stop_pop) },
  { "Red Hat Summit Radio", SONGS(radio_summit2025) },
};

#define N_STATIONS sizeof(radio_stations)/sizeof(struct radio_station_info_t)

void
radio_stations_init(void)
{
  for (uint32_t i = 0; i < N_STATIONS; i++)
    radio_stations[i].id = i;
}

uint32_t
n_radio_stations(void)
{
  return N_STATIONS;
}

const radio_station_info_t *
get_radio_stations(uint32_t id)
{
  return &radio_stations[id];
}
