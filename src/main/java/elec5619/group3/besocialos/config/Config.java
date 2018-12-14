package elec5619.group3.besocialos.config;

public class Config {
    private static Config config = new Config();

    public static Config getConfig() {
        return config;
    }

    private boolean testing = false;

    public void setTest() { testing = !testing; }
    public boolean isTest() {return testing;}

    private Config() {
    }
}
