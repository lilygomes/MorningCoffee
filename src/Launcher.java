import java.awt.EventQueue;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JMenuBar;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Image;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.IOException;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.JMenuItem;
import javax.swing.SwingConstants;
import javax.swing.JMenu;

public class Launcher extends JFrame {
	public void Launcher1() {
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() { 
				try {
					Launcher frame = new Launcher();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 * @return 
	 */
	public Launcher() {
	    JFrame.setDefaultLookAndFeelDecorated(true);
	    JFrame frame = new JFrame();
	    frame.setTitle("MorningCoffee");
		addWindowListener(new WindowAdapter() {
		});
		setResizable(false);
		setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
			}});
		setBounds(100, 100, 260, 105);
		
		JMenuBar menuBar = new JMenuBar();
		setJMenuBar(menuBar);
		
		JMenu mnApplications = new JMenu("Applications");
		menuBar.add(mnApplications);
		
		JMenuItem mntmTerminal = new JMenuItem("Terminal");
		mntmTerminal.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				 try {
					 Runtime.getRuntime().exec(new String[] {"cmd", "/K", "Start"});
				 }
				 catch(Exception e1) {
					 System.out.println("Program failed to launch.");
					 e1.printStackTrace();
				 }
			}
		}
		);
		mnApplications.add(mntmTerminal);
		
		JMenuItem mntmInternet = new JMenuItem("Internet");
		mntmInternet.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					@SuppressWarnings("unused")
					Process process = new ProcessBuilder("ChromiumPortable.exe").start();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				 }
			}
		);
		mnApplications.add(mntmInternet);
		
		JMenuItem mntmFiles = new JMenuItem("Files");
		mntmFiles.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					@SuppressWarnings("unused")
					Process process = new ProcessBuilder("explorer++.exe").start();
				 }
				 catch(Exception e1) {
					 System.out.println("Program failed to launch.");
					 e1.printStackTrace();
				 }
			}
		});
		mnApplications.add(mntmFiles);
		
		JMenuItem mntmCalculator = new JMenuItem("Calculator");
		mntmCalculator.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Calculator.calc();
			}
		});
		mnApplications.add(mntmCalculator);
		
		JMenuItem mntmPaint = new JMenuItem("Paint");
		mntmPaint.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					 Runtime.getRuntime().exec(new String[] {"cmd", "/c", "GIMPPortable.exe"});
				 }
				 catch(Exception e1) {
					 System.out.println("Program failed to launch.");
					 e1.printStackTrace();
				 }
			}
		});
		mnApplications.add(mntmPaint);
		
		JMenuItem mntmClock = new JMenuItem("Clock");
		mntmClock.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				DigitalClock.clock();
			}
		});
		mnApplications.add(mntmClock);
		
		JMenu mnSystem = new JMenu("System");
		menuBar.add(mnSystem);
		
		/*
		JMenuItem mntmSettings = new JMenuItem("Settings");
		mntmSettings.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Settings.settings();
			}
		});
		mnSystem.add(mntmSettings);
		*/
		
		JMenuItem mntmLogOut = new JMenuItem("Exit MorningCoffee");
		mntmLogOut.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				exit.exitPrompt();
			}
		});
		
		JMenuItem mntmShutDown = new JMenuItem("Shut Down");
		mntmShutDown.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Shutdown.shutdown();
			}
		}
		);
		mnSystem.add(mntmShutDown);
		mnSystem.add(mntmLogOut);
		
		JMenuItem mntmAbout = new JMenuItem("About");
		mntmAbout.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				About.about();
			}
		});
		mnSystem.add(mntmAbout);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel lblMorningcoffeeBeta = new JLabel("MorningCoffee");
		lblMorningcoffeeBeta.setVerticalAlignment(SwingConstants.BOTTOM);
		lblMorningcoffeeBeta.setBounds(12, 0, 150, 31);
		lblMorningcoffeeBeta.setFont(new Font("Yu Gothic UI", Font.PLAIN, 18));
		contentPane.add(lblMorningcoffeeBeta);
		
		JLabel lblBeta = new JLabel("Beta 2");
		lblBeta.setVerticalAlignment(SwingConstants.BOTTOM);
		lblBeta.setFont(new Font("Yu Gothic UI Light", Font.PLAIN, 13));
		lblBeta.setBounds(138, -1, 48, 31);
		contentPane.add(lblBeta);
		
		JLabel lblNew = new JLabel("");
		Image img = new ImageIcon(this.getClass().getResource("java-20x20.png")).getImage();
		lblNew.setIcon(new ImageIcon(Launcher.class.getResource("/com/sun/java/swing/plaf/windows/icons/JavaCup32.png")));
		lblNew.setBounds(210, 0, 44, 44);
		contentPane.add(lblNew);
	}
}