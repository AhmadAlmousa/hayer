/// The public web host every shared Hayer link points at.
const hayerPublicHost = 'hayer.almou.sa';

/// The public link to an app [location], such as `/discover?v=1&bbox=…`.
///
/// It opens the app where the app is installed, and the web app elsewhere.
Uri hayerPublicUri(String location) =>
    Uri.parse('https://$hayerPublicHost$location');
