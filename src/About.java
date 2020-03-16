import java.awt.EventQueue;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Image;
import java.awt.Font;
import java.awt.Label;

public class About extends JFrame {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2L;
	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void about() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					About frame = new About();
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
	public About() {
		// setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 366, 195);
		setResizable(false);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblNewLabel = new JLabel("MorningCoffee");
		lblNewLabel.setFont(new Font("Yu Gothic UI", Font.BOLD, 28));
		lblNewLabel.setBounds(12, 13, 216, 53);
		contentPane.add(lblNewLabel);
		
		JLabel lblBeta = new JLabel("Beta 2");
		lblBeta.setFont(new Font("Yu Gothic UI", Font.PLAIN, 20));
		lblBeta.setBounds(12, 59, 94, 27);
		contentPane.add(lblBeta);
		
		Label label = new Label("Developed by Frank Gomes for iD Tech");
		label.setBounds(12, 92, 247, 24);
		contentPane.add(label);
		
		Label label_1 = new Label("Build date 27/06/2018");
		label_1.setBounds(12, 111, 247, 24);
		contentPane.add(label_1);
		
		JLabel lblNew = new JLabel("");
		Image img = new ImageIcon(this.getClass().getResource("/java-80x80.png")).getImage();
		lblNew.setIcon(new ImageIcon(img));
		lblNew.setBounds(265, 36, 80, 80);
		contentPane.add(lblNew);
	}
}
