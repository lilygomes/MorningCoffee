import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Choice;
import java.awt.Color;

public class Settings extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3L;
	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void settings() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Settings frame = new Settings();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Settings() {
		// setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setResizable(false);
		setBounds(100, 100, 200, 145);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblSettings = new JLabel("Settings");
		lblSettings.setBounds(10, 13, 146, 38);
		lblSettings.setFont(new Font("Yu Gothic UI", Font.BOLD, 28));
		contentPane.add(lblSettings);
		
		Choice colourChooser = new Choice();
		colourChooser.setForeground(Color.BLACK);
		colourChooser.setBackground(Color.WHITE);
		colourChooser.setFont(new Font("Segoe UI", Font.PLAIN, 15));
		colourChooser.setBounds(10, 72, 174, 27);
		colourChooser.add("Light");
		colourChooser.add("Dark");
		colourChooser.add("Green");
		colourChooser.add("Orange");
		contentPane.add(colourChooser);
		
		JLabel lblColour = new JLabel("Colour");
		lblColour.setFont(new Font("Segoe UI", Font.PLAIN, 15));
		lblColour.setBounds(10, 50, 56, 16);
		contentPane.add(lblColour);
	}
}
